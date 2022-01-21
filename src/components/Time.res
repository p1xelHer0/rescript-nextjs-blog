@react.component
let make = (~dateString: string) => {
  let date = DateFns.parseISO(dateString)->DateFns.format("MMM d, yyy")

  <time dateTime={date}> {React.string(date)} </time>
}
