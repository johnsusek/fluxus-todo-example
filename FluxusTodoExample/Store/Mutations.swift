import Fluxus
import Foundation

enum TodoMutation: Mutation {
  case DeleteTodos(IndexSet)
  case AddTodo(String)
}
