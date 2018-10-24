import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { _ in
        return "It works!"
    }

    // Basic "Hello, world!" example
    router.get("hello") { _ in
        "Hello, world!"
    }

    try router.register(collection: TodoController())
}
