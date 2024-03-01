// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "feather-system-module",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "SystemInterfaceKit", targets: ["SystemInterfaceKit"]),
        .library(name: "SystemKit", targets: ["SystemKit"]),
        .library(name: "SystemOpenAPIGeneratorKit", targets: ["SystemOpenAPIGeneratorKit"]),
        .library(name: "SystemOpenAPIRuntimeKit", targets: ["SystemOpenAPIRuntimeKit"]),
        .library(name: "SystemMigrationKit", targets: ["SystemMigrationKit"]),
        .library(name: "SystemServerKit", targets: ["SystemServerKit"]),
        .executable(name: "SystemOpenAPIGenerator", targets: ["SystemOpenAPIGenerator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-log", from: "1.5.0"),
        .package(url: "https://github.com/apple/swift-nio", from: "2.61.0"),
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
        .package(url: "https://github.com/swift-server/swift-openapi-hummingbird", from: "2.0.0-alpha.2"),
        .package(url: "https://github.com/binarybirds/swift-nanoid", from: "1.0.0"),
        .package(url: "https://github.com/hummingbird-project/hummingbird", from: "2.0.0-alpha.2"),
        .package(url: "https://github.com/feather-framework/feather-validation", .upToNextMinor(from: "0.1.0")),
        .package(url: "https://github.com/feather-framework/feather-component", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/feather-framework/feather-relational-database", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/feather-framework/feather-relational-database-driver-sqlite", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/feather-framework/feather-openapi-spec", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/feather-framework/feather-openapi-spec-hummingbird", .upToNextMinor(from: "0.3.0")),
        .package(url: "https://github.com/feather-framework/feather-openapi-kit", .upToNextMinor(from: "0.8.0")),
        .package(url: "https://github.com/feather-framework/feather-database-kit", .upToNextMinor(from: "0.1.0")),
        .package(url: "https://github.com/feather-modules/feather-core-module", .upToNextMinor(from: "0.1.0")),
        .package(url: "https://github.com/jpsim/Yams", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "SystemInterfaceKit",
            dependencies: [
                .product(name: "CoreInterfaceKit", package: "feather-core-module")
            ]
        ),
        .target(
            name: "SystemKit",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "NanoID", package: "swift-nanoid"),
                .product(name: "FeatherValidation", package: "feather-validation"),
                .product(name: "FeatherComponent", package: "feather-component"),
                .product(name: "FeatherRelationalDatabase", package: "feather-relational-database"),
                .product(name: "DatabaseQueryKit", package: "feather-database-kit"),
                .target(name: "SystemInterfaceKit"),
            ]
        ),
        .target(
            name: "SystemOpenAPIRuntimeKit",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "CoreOpenAPIRuntimeKit", package: "feather-core-module"),
                .target(name: "SystemInterfaceKit"),
            ]
        ),

        .target(
            name: "SystemMigrationKit",
            dependencies: [
                .product(name: "FeatherComponent", package: "feather-component"),
                .product(name: "FeatherRelationalDatabase", package: "feather-relational-database"),
                .product(name: "DatabaseMigrationKit", package: "feather-database-kit"),
            ]
        ),

        // MARK: - server
        .target(
            name: "SystemServerKit",
            dependencies: [
                .target(name: "SystemOpenAPIRuntimeKit"),
                .target(name: "SystemKit"),
            ]
        ),

        // MARK: - openapi

        .executableTarget(
            name: "SystemOpenAPIGenerator",
            dependencies: [
                .product(name: "Yams", package: "Yams"),
                
                .target(name: "SystemOpenAPIGeneratorKit"),
            ]
        ),

        .target(
            name: "SystemOpenAPIGeneratorKit",
            dependencies: [
                .product(name: "FeatherOpenAPIKit", package: "feather-openapi-kit"),
                .product(name: "FeatherOpenAPIKitMacros", package: "feather-openapi-kit"),
                .product(name: "CoreOpenAPIGeneratorKit", package: "feather-core-module"),
            ],
            plugins: [
                .plugin(name: "FeatherOpenAPIGenerator", package: "feather-openapi-kit")
            ]
        ),
        // MARK: - tests
        .testTarget(
            name: "SystemInterfaceKitTests",
            dependencies: [
                .target(name: "SystemInterfaceKit")
            ]
        ),
        .testTarget(
            name: "SystemKitTests",
            dependencies: [
                .target(name: "SystemKit"),
                .target(name: "SystemMigrationKit"),
                // drivers
                .product(name: "FeatherRelationalDatabaseDriverSQLite", package: "feather-relational-database-driver-sqlite"),
            ]
        ),
        .testTarget(
            name: "SystemMigrationTests",
            dependencies: [
                .target(name: "SystemKit"),
                .target(name: "SystemMigrationKit"),
                // drivers
                .product(name: "FeatherRelationalDatabaseDriverSQLite", package: "feather-relational-database-driver-sqlite"),
            ]
        ),

        // MARK: - server tests
        .testTarget(
            name: "SystemServerKitTests",
            dependencies: [
                .product(name: "FeatherOpenAPISpec", package: "feather-openapi-spec"),
                .product(name: "FeatherOpenAPISpecHummingbird", package: "feather-openapi-spec-hummingbird"),
                .product(name: "OpenAPIHummingbird", package: "swift-openapi-hummingbird"),
                .target(name: "SystemServerKit"),
                .target(name: "SystemMigrationKit"),
                // drivers
                .product(name: "FeatherRelationalDatabaseDriverSQLite", package: "feather-relational-database-driver-sqlite"),
            ]
        ),
    ]
)
