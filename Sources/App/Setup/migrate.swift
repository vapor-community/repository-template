import FluentPostgreSQL

/// Register your model's migrations here.
public func migrate(config: inout MigrationConfig) {
    config.add(model: Todo.self, database: .psql)
}
