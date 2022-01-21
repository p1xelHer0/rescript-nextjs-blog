// getStaticProps can only return JSON-serializable content
// date must be string
type t = {title: string, date: string, id: string, body: GrayMatter.markdownString}

let directory = Node.Path.join2(Node.Process.cwd(), "_posts")

let trimMarkdownFileEnding = fileName => fileName->Js.String2.replaceByRe(%re("/\.md$/"), "")

let getAll = () => {
  let fileNames = Node.Fs.readdirSync(directory)

  let allPostsData = fileNames->Belt.Array.map(fileName => {
    let id = trimMarkdownFileEnding(fileName)

    let fullPath = Node.Path.join2(directory, fileName)
    let fileContents = Node.Fs.readFileSync(fullPath, "utf-8")

    let {data, content} = GrayMatter.read(fileContents)

    {
      body: content,
      date: data.date,
      id: id,
      title: data.title,
    }
  })

  allPostsData->Js.Array2.sortInPlaceWith((a, b) =>
    if a.date < b.date {
      1
    } else {
      -1
    }
  )
}

let getIds = () => {
  let fileNames = Node.Fs.readdirSync(directory)

  fileNames->Belt.Array.map(fileName => trimMarkdownFileEnding(fileName))
}
