import FluentSQLite
import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class TodoController: RouteCollection {
    func boot(router: Router) throws {
        let todos = router.grouped("todos")

        todos.get(use: self.index)
        todos.post(CreateTodoRequest.self, use: self.create)
        todos.put(UpdateTodoRequest.self, at: Todo.parameter, use: self.update)
        todos.post(Todo.parameter, "toggle", use: self.toggle)
        todos.delete(Todo.parameter, use: self.delete)
    }

    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[Todo]> {
        let repository = try req.make(TodoRepository.self)

        var criteria: [FilterOperator<Todo.Database, Todo>] = []

        if let title = req.query[String.self, at: "title"] {
            criteria.append(\.title == title)
        }

        return repository.findBy(criteria: criteria, orderBy: nil, on: req)
    }

    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request, payload: CreateTodoRequest) throws -> Future<Todo> {
        let repository = try req.make(TodoRepository.self)
        let todo = Todo(from: payload)

        try todo.validate()

        return repository.create(todo, on: req)
    }

    /// Updates a decoded `Todo` to the database.
    func update(_ req: Request, payload: UpdateTodoRequest) throws -> Future<Todo> {
        let repository = try req.make(TodoRepository.self)
        return try req.parameters.next(Todo.self).flatMap { todo in
            todo.title = payload.title
            todo.body = payload.body
            todo.completed = payload.completed

            try todo.validate()

            return repository.update(todo, on: req)
        }
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Todo.self).flatMap { todo in
            return todo.delete(on: req)
        }.transform(to: .noContent)
    }

    /// Toggle status of a decoded `Todo` to the database.
    func toggle(_ req: Request) throws -> Future<Todo> {
        let repository = try req.make(TodoRepository.self)
        return try req.parameters.next(Todo.self).flatMap { todo in
            todo.completed = !todo.completed
            return repository.update(todo, on: req)
        }
    }
}
