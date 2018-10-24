import FluentPostgreSQL
import Vapor

/// A single entry of a Todo list.
final class Todo: Codable {
    /// The unique identifier for this `Todo`.
    var id: Int?

    /// A title describing what this `Todo` entails.
    var title: String

    var createdAt: Date?
    var updatedAt: Date?
    var deletedAt: Date?

    /// Creates a new `Todo`.
    init(id: Int? = nil, title: String) {
        self.id = id
        self.title = title
    }
}

/// Allows `Todo` to be used as Fluent model.
extension Todo: PostgreSQLModel {
    static var entity = "todos"

    static var createdAtKey: TimestampKey? = \.createdAt
    static var deletedAtKey: TimestampKey? = \.deletedAt
    static var updatedAtKey: TimestampKey? = \.updatedAt
}

/// Allows `Todo` to be used as a dynamic migration.
extension Todo: Migration {}

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension Todo: Content {}

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Todo: Parameter {}

extension Todo: Validatable {
    static func validations() throws -> Validations<Todo> {
        var validations = Validations(Todo.self)
        try validations.add(\.title, !.empty)
        return validations
    }
}
