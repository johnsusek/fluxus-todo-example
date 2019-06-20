import Fluxus

struct TodoState: FluxState {
  var todos: [Int: Todo] = [
    22: Todo(id: 22, name: "Cut the lawn", done: false),
    23: Todo(id: 23, name: "Clean the gutters", done: true),
    24: Todo(id: 24, name: "Take out garbage", done: false)
  ]

  var list: [Todo] {
    todos.map { $1 }.sorted { (a, b) -> Bool in
      a.id < b.id
    }
  }
}

struct RootState {
  var todo = TodoState()
}
