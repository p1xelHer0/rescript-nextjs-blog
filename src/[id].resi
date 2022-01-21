open Next

type props
type params

let default: props => React.element
let getStaticProps: GetStaticProps.t<props, params, _>
let getStaticPaths: GetStaticPaths.t<params>
