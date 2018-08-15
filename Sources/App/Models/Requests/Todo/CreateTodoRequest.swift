import Vapor

struct CreateTodoRequest: Content {
    var title: String
    var body: String?
}

extension Todo {
    convenience init(from payload: CreateTodoRequest) {
        self.init(title: payload.title, body: payload.body)
    }
}
