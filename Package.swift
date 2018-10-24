// swift-tools-version:4.1
import PackageDescription

let package = Package(
    name: "VaporApp",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        // 🐘 Swift ORM (queries, models, relations, etc) built on PostgreSQL.
        .package(url: "https://github.com/vapor/fluent-postgresql.git", from: "1.0.0"),
        // ⚙️ A collection of Swift extensions for wide range of Vapor data types and classes.
        .package(url: "https://github.com/vapor-community/vapor-ext.git", from: "0.3.1"),

        // MARK: Testing Packages

        // 🛠 Tools for testing Vapor apps easier
        .package(url: "https://gitlab.com/gperdomor/vapor-test-helpers.git", from: "0.1.1"),
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentPostgreSQL", "Vapor", "VaporExt"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App", "VaporTestHelpers"]),
    ]
)
