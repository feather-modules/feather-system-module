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
        .library(name: "SystemModuleInterface", targets: ["SystemModuleInterface"]),
        .library(name: "SystemModuleMigration", targets: ["SystemModuleMigration"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.5.0"),
        .package(url: "https://github.com/apple/swift-nio", from: "2.61.0"),
        .package(url: "https://github.com/feather-framework/feather-validation", .upToNextMinor(from: "0.1.0")),
        .package(url: "https://github.com/feather-framework/feather-component", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/feather-framework/feather-relational-database", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/feather-framework/feather-relational-database-driver-sqlite", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/feather-framework/feather-openapi-kit", .upToNextMinor(from: "0.8.0")),
        .package(url: "https://github.com/feather-framework/feather-database-kit", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/feather-modules/feather-core-module", .upToNextMinor(from: "0.6.0")),
    ],
    targets: [
        .target(
            name: "SystemModuleInterface",
            dependencies: [
                .product(name: "CoreModuleInterface", package: "feather-core-module"),
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
                .target(name: "SystemModuleInterface"),
                
            ]
        ),

        .target(
            name: "SystemModuleMigration",
            dependencies: [
                .product(name: "FeatherComponent", package: "feather-component"),
                .product(name: "FeatherRelationalDatabase", package: "feather-relational-database"),
                .product(name: "DatabaseMigrationKit", package: "feather-database-kit"),
                .target(name: "SystemModuleInterface"),
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
            name: "SystemModuleInterfaceTests",
            dependencies: [
                .target(name: "SystemModuleInterface")
            ]
        ),
        .testTarget(
            name: "SystemModuleTests",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .target(name: "SystemModule"),
                .target(name: "SystemModuleMigration"),
                // drivers
                .product(name: "FeatherRelationalDatabaseDriverSQLite", package: "feather-relational-database-driver-sqlite"),
            ]
        ),
        .testTarget(
            name: "SystemModuleMigrationTests",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .target(name: "SystemModule"),
                .target(name: "SystemModuleMigration"),
                // drivers
                .product(name: "FeatherRelationalDatabaseDriverSQLite", package: "feather-relational-database-driver-sqlite"),
            ]
        ),
    ]
)
