import Vapor

struct CreateTodoRequest: Content {
    var title: String
}

extension Todo {
    convenience init(from payload: CreateTodoRequest) {
        self.init(title: payload.title)
    }
}
