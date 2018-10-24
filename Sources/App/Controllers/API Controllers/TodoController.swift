import VaporExt

/// Controls basic CRUD operations on `Todo`s.
final class TodoController: RouteCollection {
    func boot(router: Router) throws {
        let todos = router.grouped("todos")

        todos.get(use: index)
        todos.post(CreateTodoRequest.self, use: create)
        todos.put(UpdateTodoRequest.self, at: Todo.parameter, use: update)
        todos.delete(Todo.parameter, use: delete)
    }

    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[Todo]> {
        let criteria: [FilterOperator<Todo.Database, Todo>] = try [
            req.filter(\Todo.title, at: "title")
        ].compactMap { $0 }

        var sort: [Todo.Database.QuerySort] = try [
            req.sort(\Todo.title, as: "title"),
            req.sort(\Todo.createdAt, as: "created_at")
        ].compactMap { $0 }

        if sort.isEmpty {
            let defaultSort = Todo.Database.querySort(Todo.Database.queryField(.keyPath(\Todo.createdAt)), .ascending)
            sort.append(defaultSort)
        }

        let repository = try req.make(TodoRepository.self)

        return repository.find(by: criteria, sortBy: sort, on: req)
    }

    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request, payload: CreateTodoRequest) throws -> Future<Todo> {
        let todo = Todo(from: payload)

        let repository = try req.make(TodoRepository.self)

        return repository.create(todo, on: req)
    }

    /// Updates a decoded `Todo` to the database.
    func update(_ req: Request, payload: UpdateTodoRequest) throws -> Future<Todo> {
        return try req.parameters.next(Todo.self).flatMap { todo in
            todo.title = payload.title

            let repository = try req.make(TodoRepository.self)

            return repository.update(todo, on: req)
        }
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        let repository = try req.make(TodoRepository.self)

        return try req.parameters.next(Todo.self).flatMap { todo in
            repository.delete(todo, on: req)
        }.transform(to: .noContent)
    }
}
