import Fluxus

struct TodoCommitter: Committer {
  func commit(state: TodoState, mutation: TodoMutation) -> TodoState {
    var state = state

    print(mutation)

    switch mutation {

    case .DeleteTodo(let todo):
      state.todos[todo.id] = nil

    case .AddTodo(let name):
      let maxId = state.list.max { $0.id < $1.id }?.id ?? 0
      state.todos[maxId + 1] = Todo(id: maxId + 1, name: name, done: false)

    case .UpdateTodo(let todo):
      state.todos[todo.id] = todo

    case .ToggleDone(let id):
      state.todos[id]?.done.toggle()

    }

    return state
  }
}
