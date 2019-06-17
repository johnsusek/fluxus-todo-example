import Fluxus

struct TodoCommitter: Committer {
  func commit(state: TodoState, mutation: TodoMutation) -> TodoState {
    var state = state

    switch mutation {

    case .DeleteTodos(let indexSet):
      indexSet.forEach { state.todos.remove(at: $0) }

    case .AddTodo(let name):
      let maxId = state.todos.max { $0.id < $1.id }?.id ?? 0
      state.todos.append(Todo(id: maxId + 1, name: name))
    }

    return state
  }
}
