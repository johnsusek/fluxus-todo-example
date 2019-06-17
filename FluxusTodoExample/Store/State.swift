import Fluxus

struct TodoState: FluxState {
  var todos: [Todo] = [
    Todo(id: 1, name: "Cut the lawn"),
    Todo(id: 2, name: "Clean the gutters"),
    Todo(id: 3, name: "Take out garbage")
  ]

  func todoIndex(withId id: Int) -> Int {
    return todos.firstIndex(where: { $0.id == id })!
  }
}

struct RootState {
  var todo = TodoState()
}
