module Header = {
  @react.component
  let make = (~home: option<bool>=?) => {
    let home' = Belt.Option.getWithDefault(home, false)

    <header>
      {home'
        ? <> <h1> <Link href="/"> {MetaData.name->React.string} </Link> </h1> </>
        : <h3> <Link href="/"> {MetaData.name->React.string} </Link> </h3>}
    </header>
  }
}

module Navigation = {
  @react.component
  let make = (~home: option<bool>=?) => {
    let home' = Belt.Option.getWithDefault(home, false)
    <>
      {React.string(`home: ${string_of_bool(home')}`)}
      <ul>
        <li>
          <Link href={`https://twitter.com/${MetaData.twitter}`} _external=true>
            {React.string("twitter")}
          </Link>
        </li>
        <li>
          <Link href={`https://github.com/${MetaData.github}`} _external=true>
            {React.string("github")}
          </Link>
        </li>
        <li> <Link href="/rss.xml" _external=true> {"rss"->React.string} </Link> </li>
      </ul>
    </>
  }
}

@react.component
let make = (~children: React.element, ~home: option<bool>=?) =>
  <div> <Header ?home /> <Navigation ?home /> <main> {children} </main> </div>
