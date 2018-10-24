import Fluent
import VaporExt

protocol TodoRepository: Service {
    func find(by criteria: [FilterOperator<Todo.Database, Todo>], sortBy: [Todo.Database.QuerySort]?, on connectable: DatabaseConnectable) -> Future<[Todo]>

    func find(by criteria: [FilterOperator<Todo.Database, Todo>], sortBy: [Todo.Database.QuerySort]?, on connectable: DatabaseConnectable, withSoftDeleted: Bool) -> Future<[Todo]>

    func create(_ todo: Todo, on connectable: DatabaseConnectable) -> Future<Todo>

    func update(_ todo: Todo, on connectable: DatabaseConnectable) -> Future<Todo>

    func delete(_ todo: Todo, on connectable: DatabaseConnectable) -> Future<Void>
}

final class SQLTodoRepository: TodoRepository {
    func find(by criteria: [FilterOperator<Todo.Database, Todo>] = [FilterOperator<Todo.Database, Todo>](), sortBy: [Todo.Database.QuerySort]? = nil, on connectable: DatabaseConnectable) -> Future<[Todo]> {
        return find(by: criteria, sortBy: sortBy, on: connectable, withSoftDeleted: false)
    }

    func find(by criteria: [FilterOperator<Todo.Database, Todo>] = [FilterOperator<Todo.Database, Todo>](), sortBy: [Todo.Database.QuerySort]? = nil, on connectable: DatabaseConnectable, withSoftDeleted: Bool) -> Future<[Todo]> {
        return Todo.find(by: criteria, sortBy: sortBy, on: connectable, withSoftDeleted: withSoftDeleted)
    }

    func create(_ model: Todo, on connectable: DatabaseConnectable) -> Future<Todo> {
        return model.create(on: connectable)
    }

    func update(_ model: Todo, on connectable: DatabaseConnectable) -> Future<Todo> {
        return model.update(on: connectable)
    }

    func delete(_ model: Todo, on connectable: DatabaseConnectable) -> Future<Void> {
        return model.delete(on: connectable)
    }
}
