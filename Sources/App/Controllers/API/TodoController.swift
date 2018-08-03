import Vapor
import FluentSQLite

/// Controls basic CRUD operations on `Todo`s.
final class TodoController: RouteCollection {
    func boot(router: Router) throws {
        let todos = router.grouped("todos")

        todos.get(use: self.index)
        todos.post(Todo.self, use: self.create)
        todos.delete(Todo.parameter, use: self.delete)
    }

    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[Todo]> {
        let repository = try req.make(TodoRepository.self)

        var criteria: [FilterOperator<Todo.Database, Todo>] = []

        if let title = req.query[String.self, at: "title"] {
            criteria.append(.make(\Todo.title, .equal, [title]))
        }

        return repository.findBy(criteria: criteria, orderBy: nil, on: req)
    }

    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request, payload: Todo) throws -> Future<Todo> {
        let repository = try req.make(TodoRepository.self)
        return repository.save(model: payload, on: req)
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Todo.self).flatMap { todo in
            return todo.delete(on: req)
        }.transform(to: .noContent)
    }
}
