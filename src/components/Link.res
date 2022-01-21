@react.component
let make = (
  ~_as: option<string>=?,
  ~_external: option<bool>=?,
  ~children: React.element,
  ~className: option<string>=?,
  ~href,
  ~passHref: option<bool>=?,
) => {
  Belt.Option.getWithDefault(_external, false)
    ? <a href target="_blank" rel="noopener noreferrer" ?className> {children} </a>
    : <Next.Link href={href} ?_as ?passHref>
        {Belt.Option.getWithDefault(passHref, false) ? {children} : <a ?className> {children} </a>}
      </Next.Link>
}
