module Fs = {
  @module("fs") external readdirSync: string => array<string> = "readdirSync"

  // We are only using readFileSync(path, "utf-8"),
  // no fancy flags, only the utf-8 encoding.
  // According to the docs
  // https://nodejs.org/api/fs.html#fs_fs_readfilesync_path_options
  // this returns a string, not a Buffer
  @module("fs") external readFileSync: (string, string) => string = "readFileSync"
}

module Path = {
  @module("path") external join2: (string, string) => string = "join"
}

module Process = {
  @module("process") external cwd: unit => string = "cwd"
}
