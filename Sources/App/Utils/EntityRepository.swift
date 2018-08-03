import FluentSQLite
import Vapor

protocol EntityRepository: class, Service {
    associatedtype M: Model

    func find(_ id: M.ID, on connectable: DatabaseConnectable) -> Future<M?>

    func findAll(on connectable: DatabaseConnectable) -> Future<[M]>

    func findBy(criteria: [FilterOperator<M.Database, M>], orderBy: [M.Database.QuerySort]?, on connectable: DatabaseConnectable) -> Future<[M]>

    func findOneBy(criteria: [FilterOperator<M.Database, M>], on connectable: DatabaseConnectable) -> Future<M?>
}

extension EntityRepository {
    func find(_ id: M.ID, on connectable: DatabaseConnectable) -> Future<M?> {
        return M.find(id, on: connectable)
    }

    func findAll(on connectable: DatabaseConnectable) -> Future<[M]> {
        return self.findBy(criteria: [FilterOperator<M.Database, M>](), on: connectable)
    }

    func findBy(criteria: [FilterOperator<M.Database, M>] = [FilterOperator<M.Database, M>](), orderBy: [M.Database.QuerySort]? = nil, on connectable: DatabaseConnectable) -> Future<[M]> {
        var query = M.query(on: connectable)

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

    func findOneBy(criteria: [FilterOperator<M.Database, M>], on connectable: DatabaseConnectable) -> Future<M?> {
        return self.findBy(criteria: criteria, on: connectable).map { models in
            return models[0]
        }
    }
}
