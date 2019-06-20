import SwiftUI

struct TodoView: View {
  @EnvironmentObject var store: RootStore
  let id: Int

  var todo: Todo! {
    return store.state.todo.todos[id]!
  }

  var myToggleBinding = Binding<String> (
    getValue: {
      ""
  },
    setValue: { value in
      print(value)
      //      rootStore.commit(CounterMutation.SetMyBool(value))
  })

  var body: some View {
    return HStack {
      Button(action: toggleDone) {
        Image(systemName: self.todo.done ? "checkmark.circle.fill" : "circle")
          .font(Font.body.weight(.ultraLight))
          .imageScale(.large)
          .foregroundColor(self.todo.done ? .blue : .gray)
      }

      Text(todo.name)
      TextField(myToggleBinding, onEditingChanged: handleEditingChanged)
    }
  }

  func toggleDone() {
    store.commit(TodoMutation.ToggleDone(id))
  }

  func handleEditingChanged(_ currentlyBeingEdited: Bool) {
    if currentlyBeingEdited || todo.name.isEmpty { return }
    store.commit(TodoMutation.UpdateTodo(todo))
  }
}
