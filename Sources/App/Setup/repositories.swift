import Vapor

public func setupRepositories(_ config: inout Config, _ env: inout Environment, _ services: inout Services) {
    services.register(SQLTodoRepository(), as: TodoRepository.self)

    preferDatabaseRepositories(config: &config)
}

private func preferDatabaseRepositories(config: inout Config) {
    config.prefer(SQLTodoRepository.self, for: TodoRepository.self)
}
