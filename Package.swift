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
        .library(name: "SystemOpenAPIGeneratorKit", targets: ["SystemOpenAPIGeneratorKit"]),
        .library(name: "SystemModule", targets: ["SystemModule"]),
        .library(name: "SystemModuleKit", targets: ["SystemModuleKit"]),
        .library(name: "SystemModuleDatabaseKit", targets: ["SystemModuleDatabaseKit"]),
        .library(name: "SystemModuleMigrationKit", targets: ["SystemModuleMigrationKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.5.0"),
        .package(url: "https://github.com/apple/swift-nio", from: "2.61.0"),
        .package(url: "https://github.com/feather-framework/feather-access-control", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/feather-framework/feather-validation", .upToNextMinor(from: "0.1.0")),
        .package(url: "https://github.com/feather-framework/feather-component", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/feather-framework/feather-relational-database", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/feather-framework/feather-relational-database-driver-sqlite", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/feather-framework/feather-openapi-kit", .upToNextMinor(from: "0.9.0")),
        .package(url: "https://github.com/feather-framework/feather-database-kit", .upToNextMinor(from: "0.7.0")),
        .package(url: "https://github.com/feather-modules/feather-core-module", .upToNextMinor(from: "0.12.0")),
    ],
    targets: [
        .target(
            name: "SystemModuleKit",
            dependencies: [
                .product(name: "FeatherACL", package: "feather-access-control"),
                .product(name: "CoreModuleKit", package: "feather-core-module"),
            ]
        ),
        .target(
            name: "SystemModule",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "FeatherValidation", package: "feather-validation"),
                .product(name: "FeatherComponent", package: "feather-component"),
                .product(name: "FeatherRelationalDatabase", package: "feather-relational-database"),
                .product(name: "DatabaseQueryKit", package: "feather-database-kit"),
                .product(name: "CoreModule", package: "feather-core-module"),
                .target(name: "SystemModuleDatabaseKit"),
            ]
        ),

        .target(
            name: "SystemModuleDatabaseKit",
            dependencies: [
                .product(name: "DatabaseQueryKit", package: "feather-database-kit"),
                .target(name: "SystemModuleKit"),
            ]
        ),
    
        .target(
            name: "SystemModuleMigrationKit",
            dependencies: [
                .product(name: "FeatherComponent", package: "feather-component"),
                .product(name: "FeatherRelationalDatabase", package: "feather-relational-database"),
                .product(name: "DatabaseMigrationKit", package: "feather-database-kit"),
                .target(name: "SystemModuleDatabaseKit"),
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
            name: "SystemModuleKitTests",
            dependencies: [
                .target(name: "SystemModuleKit")
            ]
        ),
        .testTarget(
            name: "SystemModuleTests",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .target(name: "SystemModule"),
                .target(name: "SystemModuleMigrationKit"),
                // drivers
                .product(name: "FeatherRelationalDatabaseDriverSQLite", package: "feather-relational-database-driver-sqlite"),
            ]
        ),
        .testTarget(
            name: "SystemModuleMigrationKitTests",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .target(name: "SystemModule"),
                .target(name: "SystemModuleMigrationKit"),
                // drivers
                .product(name: "FeatherRelationalDatabaseDriverSQLite", package: "feather-relational-database-driver-sqlite"),
            ]
        ),
    ]
)
