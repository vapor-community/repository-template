import Vapor

struct UpdateTodoRequest: Content {
    var title: String
    var body: String?
    var completed: Bool
}
