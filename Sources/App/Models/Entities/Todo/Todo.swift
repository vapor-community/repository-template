import FluentSQLite
import Vapor

/// A single entry of a Todo list.
final class Todo: Codable {
    /// The unique identifier for this `Todo`.
    var id: Int?

    /// A title describing what this `Todo` entails.
    var title: String

    /// A details describing what this `Todo` entails.
    var body: String?

    /// Indicates whether `Todo` was completed.
    var completed: Bool = false

    var createdAt: Date?
    var updatedAt: Date?
    var deletedAt: Date?

    /// Creates a new `Todo`.
    init(id: Int? = nil, title: String, body: String?) {
        self.id = id
        self.title = title
        self.body = body
    }
}

extension Todo {
    static var createdAtKey: TimestampKey? = \.createdAt
    static var updatedAtKey: TimestampKey? = \.updatedAt
    static var deletedAtKey: TimestampKey? = \.deletedAt
}

/// Allows `Todo` to be used as Fluent model.
extension Todo: SQLiteModel { }

/// Allows `Todo` to be used as a dynamic migration.
extension Todo: Migration { }

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension Todo: Content { }

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Todo: Parameter { }
