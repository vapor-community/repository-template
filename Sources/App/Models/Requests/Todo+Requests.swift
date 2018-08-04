import Vapor

extension Todo {
    struct CreateRequest: Content {
        var title: String
        var body: String?
    }

    convenience init(from payload: CreateRequest) {
        self.init(title: payload.title, body: payload.body)
    }

    struct UpdateRequest: Content {
        var title: String
        var body: String?
        var completed: Bool
    }
}
