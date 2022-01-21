module Typeline: {
  type t<'i, 'o>

  let task: (~name: string, 'i => Js.Promise.t<'o>) => t<'i, 'o>

  let seq: (t<'a, 'b>, t<'b, 'c>) => t<'a, 'c>

  let parallel: (t<'a, 'b>, t<'a, 'c>) => t<'a, ('b, 'c)>

  let run: ('i, ~pipeline: t<'i, 'o>) => Js.Promise.t<'o>
} = {
  type task<'i, 'o> = {
    name: string,
    fn: 'i => Js.Promise.t<'o>,
  }

  type rec t<'i, 'o> =
    | Id: t<'i, 'i>
    | Task(task<'i, 'o>): t<'i, 'o>
    | Seq(t<'i, 'o2>, t<'o2, 'o>): t<'i, 'o>
    | Fork(t<'i, 'o>, t<'i, 'o2>): t<'i, ('o, 'o2)>

  let task = (~name, fn) => Task({name: name, fn: fn})

  let seq = (a, b) => Seq(a, b)

  let parallel = (a, b) => Fork(a, b)

  let rec _run:
    type i o. (t<i, o>, i) => Js.Promise.t<o> =
    (t, i) => {
      switch t {
      | Id => Js.Promise.resolve(i)
      | Task({name, fn}) => {
          Js.log("[xray::task] Started " ++ name)
          fn(i) |> Js.Promise.then_(result => {
            Js.log("[xray::task] Finished " ++ name)
            Js.Promise.resolve(result)
          })
        }
      | Seq(task, more) => _run(task, i) |> Js.Promise.then_(_run(more))
      | Fork(task, more) => Js.Promise.all2((_run(task, i), _run(more, i)))
      }
    }

  let run = (input, ~pipeline) => {
    Js.log("[xray::runner] running pipeline")
    _run(pipeline, input) |> Js.Promise.then_(x => {
      Js.log("[xray::runner] pipeline completed")
      Js.Promise.resolve(x)
    })
  }
}
