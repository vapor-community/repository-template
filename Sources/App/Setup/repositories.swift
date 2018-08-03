import Vapor

public func setupRepositories(_ config: inout Config, _ env: inout Environment, _ services: inout Services) {
    services.register(TodoRepository(), as: TodoRepository.self)
}
