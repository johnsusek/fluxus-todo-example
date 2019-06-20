import SwiftUI
import Combine
import Fluxus

let rootStore = RootStore()

final class RootStore: BindableObject {
  var didChange = PassthroughSubject<RootStore, Never>()

  var state = RootState() {
    didSet {
      didChange.send(self)
    }
  }

  func commit(_ mutation: Mutation) {
    switch mutation {
    case is TodoMutation:
      state.todo = TodoCommitter().commit(state: self.state.todo, mutation: mutation as! TodoMutation)
    default:
      print("Unknown mutation type!")
    }
  }
}
