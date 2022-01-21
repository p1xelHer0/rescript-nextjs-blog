type data = {
  title: string,
  date: string,
}

type markdownString

type t = {
  data: data,
  content: markdownString,
}

@module external read: string => t = "gray-matter"
