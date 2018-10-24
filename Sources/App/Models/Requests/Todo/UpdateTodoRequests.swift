import Vapor

struct UpdateTodoRequest: Content {
    var title: String
}
