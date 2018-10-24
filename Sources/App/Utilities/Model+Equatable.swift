import Fluent

public extension Model where Self: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.fluentID == rhs.fluentID
    }
}
