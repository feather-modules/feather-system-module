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
        .library(name: "SystemModule", targets: ["SystemModule"]),
        .library(name: "SystemModuleKit", targets: ["SystemModuleKit"]),
        .library(name: "SystemModuleDatabaseKit", targets: ["SystemModuleDatabaseKit"]),
        .library(name: "SystemModuleMigrationKit", targets: ["SystemModuleMigrationKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio", from: "2.61.0"),
        .package(url: "https://github.com/feather-framework/feather-module-kit", .upToNextMinor(from: "0.1.0")),
        .package(url: "https://github.com/feather-framework/feather-database-kit", .upToNextMinor(from: "0.7.0")),
        .package(url: "https://github.com/feather-framework/feather-relational-database-driver-sqlite", .upToNextMinor(from: "0.2.0")),
    ],
    targets: [
        .target(
            name: "SystemModuleKit",
            dependencies: [
                .product(name: "FeatherModuleKit", package: "feather-module-kit"),
            ]
        ),

        .target(
            name: "SystemModuleDatabaseKit",
            dependencies: [
                .target(name: "SystemModuleKit"),
            ]
        ),
    
        .target(
            name: "SystemModuleMigrationKit",
            dependencies: [
                .product(name: "DatabaseMigrationKit", package: "feather-database-kit"),
                .target(name: "SystemModuleDatabaseKit"),
            ]
        ),

        .target(
            name: "SystemModule",
            dependencies: [
                .target(name: "SystemModuleDatabaseKit"),
            ]
        ),

        .testTarget(
            name: "SystemModuleKitTests",
            dependencies: [
                .target(name: "SystemModuleKit")
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
        
    ]
)
