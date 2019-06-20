import SwiftUI

struct TodoAdd: View {
  @EnvironmentObject var store: RootStore
  @State var draft = ""

  var body: some View {
    TextField($draft, placeholder: Text("What needs to be done?"), onEditingChanged: handleEditingChanged)
  }

  func handleEditingChanged(_ currentlyBeingEdited: Bool) {
    if currentlyBeingEdited || draft.isEmpty { return }
    store.commit(TodoMutation.AddTodo(draft))
    draft = ""
  }
}

