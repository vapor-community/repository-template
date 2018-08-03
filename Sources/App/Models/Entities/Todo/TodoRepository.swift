import Vapor
import Fluent

protocol TodoRepository: Service {
    func find(_ id: Todo.ID, on connectable: DatabaseConnectable) -> Future<Todo?>

    func findAll(on connectable: DatabaseConnectable) -> Future<[Todo]>

    func findBy(criteria: [FilterOperator<Todo.Database, Todo>], orderBy: [Todo.Database.QuerySort]?, on connectable: DatabaseConnectable) -> Future<[Todo]>

    func findOneBy(criteria: [FilterOperator<Todo.Database, Todo>], on connectable: DatabaseConnectable) -> Future<Todo?>

    func count(on connectable: DatabaseConnectable) -> Future<Int>

    func save(model: Todo, on connectable: DatabaseConnectable) -> Future<Todo>
}

final class SQLTodoRepository: TodoRepository {
    func find(_ id: Todo.ID, on connectable: DatabaseConnectable) -> Future<Todo?> {
        return Todo.find(id, on: connectable)
    }

    func findAll(on connectable: DatabaseConnectable) -> Future<[Todo]> {
        return self.findBy(criteria: [FilterOperator<Todo.Database, Todo>](), on: connectable)
    }

    func findBy(criteria: [FilterOperator<Todo.Database, Todo>] = [FilterOperator<Todo.Database, Todo>](), orderBy: [Todo.Database.QuerySort]? = nil, on connectable: DatabaseConnectable) -> Future<[Todo]> {
        var query = Todo.query(on: connectable)

        criteria.forEach { filter in
            query = query.filter(filter)
        }

        if let orderBy = orderBy {
            orderBy.forEach { order in
                query = query.sort(order)
            }
        }

        return query.all()
    }

    func findOneBy(criteria: [FilterOperator<Todo.Database, Todo>], on connectable: DatabaseConnectable) -> Future<Todo?> {
        var query = Todo.query(on: connectable)

        criteria.forEach { filter in
            query = query.filter(filter)
        }

        return query.first()
    }

    func count(on connectable: DatabaseConnectable) -> Future<Int> {
        return Todo.query(on: connectable).count()
    }

    func save(model: Todo, on connectable: DatabaseConnectable) -> Future<Todo> {
        return model.save(on: connectable)
    }
}
