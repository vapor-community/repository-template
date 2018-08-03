import Vapor
import Fluent

class TodoRepository: EntityRepository {
    typealias M = Todo

    func count(on connectable: DatabaseConnectable) -> EventLoopFuture<Int> {
        return M.query(on: connectable).count()
    }

    func save(model: M, on connectable: DatabaseConnectable) -> EventLoopFuture<M> {
        return model.save(on: connectable)
    }
}
