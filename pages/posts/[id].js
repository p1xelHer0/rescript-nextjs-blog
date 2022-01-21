import PostRes from "src/[id].js";

// This can be re-exported as is (no Fast-Refresh issues)
export { getStaticProps, getStaticPaths } from "src/[id].js";

// Note:
// We need to wrap the make call with
// a Fast-Refresh conform function name,
// (in this case, uppercased first letter)
//
// If you don't do this, your Fast-Refresh will
// not work!
export default function Post(props) {
  return <PostRes {...props} />;
}
