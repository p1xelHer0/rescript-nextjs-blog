type props = {
  date: string,
  html: string,
  next: Js.Null.t<Post.t>,
  previous: Js.Null.t<Post.t>,
  title: string,
}

let a = "2" + 7

type params = {id: string}

let default = props => {
  let next = Js.Null.toOption(props.next)
  let previous = Js.Null.toOption(props.previous)

  <MainLayout>
    <article>
      <header />
      <Time dateString={props.date} />
      <section> {React.string(props.title)} </section>
      <section dangerouslySetInnerHTML={{"__html": props.html}} />
    </article>
    {switch previous {
    | None => React.null
    | Some(post) => <Link href={post.id}> {React.string(`<- ${post.title}`)} </Link>
    }}
    {React.string(" - ")}
    {switch next {
    | None => React.null
    | Some(post) => <Link href={post.id}> {React.string(`${post.title} ->`)} </Link>
    }}
  </MainLayout>
}

let getStaticProps = ({Next.GetStaticProps.params: params}) => {
  let allPosts = Post.getAll()
  let postIndex = allPosts->Js.Array2.findIndex(post => post.id === params.id)

  let post = allPosts[postIndex]

  let next = allPosts->Belt.Array.get(postIndex - 1)->Js.Null.fromOption
  let previous = allPosts->Belt.Array.get(postIndex + 1)->Js.Null.fromOption

  let props = {
    date: post.date,
    // TODO: Implement markdown-renderer here
    html: MarkdownRenderer.make(post.body),
    next: next,
    previous: previous,
    title: post.title,
  }

  Js.Promise.resolve({"props": props})
}

let getStaticPaths = () => {
  open Next
  let ids = Post.getIds()

  let paths = ids->Belt.Array.map(id => {
    let path: GetStaticPaths.path<params> = {
      params: {id: id},
    }
    path
  })

  let staticPaths: GetStaticPaths.return<params> = {paths: paths, fallback: false}

  Js.Promise.resolve(staticPaths)
}
