import SwiftUI

struct ContentView : View {
  @EnvironmentObject var store: RootStore
  @State var draft = ""

  var body: some View {
    List {
      ForEach(store.state.todo.todos) { todo in
        TodoView(todo: self.$store.state.todo.todos[self.store.state.todo.todoIndex(withId: todo.id)])
      }.onDelete(perform: handleDelete)

      TextField($draft, placeholder: Text("What needs to be done?"), onCommit: handleCommit)
    }
  }

  func handleDelete(with indexSet: IndexSet) {
    store.commit(TodoMutation.DeleteTodos(indexSet))
  }

  func handleCommit() {
    if draft.isEmpty { return; }
    store.commit(TodoMutation.AddTodo(draft))
    draft = ""
  }
}

struct TodoView: View {
  @Binding var todo: Todo

  var body: some View {
    TextField($todo.name)
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(RootStore())
  }
}
#endif
