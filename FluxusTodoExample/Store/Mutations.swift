import Fluxus
import Foundation

enum TodoMutation: Mutation {
  case DeleteTodo(Todo)
  case AddTodo(String)
  case UpdateTodo(Todo)
  case ToggleDone(Int)
}
