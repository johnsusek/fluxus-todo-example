import SwiftUI

struct ContentView : View {
  @EnvironmentObject var store: RootStore

  var body: some View {
    List {
      ForEach(store.state.todo.list) { todo in
        TodoView(id: todo.id)
      }.onDelete(perform: handleDelete)

      TodoAdd()
    }
  }

  func handleDelete(with indexSet: IndexSet) {
    indexSet.forEach { index in
      store.commit(TodoMutation.DeleteTodo(store.state.todo.list[index]))
    }
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(rootStore)
  }
}
#endif
