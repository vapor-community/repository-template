import FluentPostgreSQL
import Vapor

/// Register your application's databases here.
public func databases(config: inout DatabasesConfig) throws {
    let todosUrl = Environment.get("DATABASE_URL", "postgres://vapor:password@localhost:5432/todos")

    guard let todosConfig = PostgreSQLDatabaseConfig(url: todosUrl) else { throw Abort(.internalServerError) }

    /// Register the databases
    let todosDB = PostgreSQLDatabase(config: todosConfig)

    config.add(database: todosDB, as: .psql)

    if Environment.get("DATABASE_LOGS", false) {
        config.enableLogging(on: .psql)
    }
}
