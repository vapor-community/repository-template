import Vapor

/// Register your application's commands here.
public func commands(config: inout CommandConfig) {
    config.useFluentCommands()
}
