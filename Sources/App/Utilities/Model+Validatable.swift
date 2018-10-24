import Fluent
import Vapor

public extension Model where Self: Validatable {
    public func willCreate(on conn: Database.Connection) throws -> Future<Self> {
        try validate()
        return conn.future(self)
    }

    public func willUpdate(on conn: Database.Connection) throws -> Future<Self> {
        try validate()
        return conn.future(self)
    }
}
