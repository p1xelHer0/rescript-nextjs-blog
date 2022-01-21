type t = GrayMatter.markdownString => string

type highlight = (string, string) => string
type sanitizer = string => string
type renderer = unit
type tokenizer = unit
type walkTokens = tokenizer => tokenizer

@deriving(abstract)
type options = {
  @optional baseUrl: string,
  @optional breaks: bool,
  @optional gfm: bool,
  @optional headerIds: bool,
  @optional headerPrefix: string,
  @optional highlight: highlight,
  @optional langPrefix: string,
  @optional mangle: bool,
  @optional pedantic: bool,
  @optional renderer: renderer,
  @optional sanitize: bool,
  @optional sanitizer: sanitizer,
  @optional silent: bool,
  @optional smartLists: bool,
  @optional smartypants: bool,
  @optional tokenizer: tokenizer,
  @optional walkTokens: walkTokens,
  @optional xhtml: bool,
}

@module external make: unit => t = "marked"
