//
//  File.swift
//
//
//  Created by Tibor Bodecs on 04/02/2024.
//

import DatabaseMigrationKit
import FeatherComponent
import FeatherRelationalDatabase
import FeatherRelationalDatabaseDriverSQLite
import Logging
import MigrationKit
import NIO
import SQLKit
import SystemModuleInterface
import SystemModuleMigration
import XCTest

@testable import SystemModule

final class ServiceKitTests: XCTestCase {

    func testExample() async throws {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let threadPool = NIOThreadPool(numberOfThreads: 1)
        threadPool.start()

        let components = ComponentRegistry()
        try await components.addRelationalDatabase(
            SQLiteRelationalDatabaseComponentContext(
                eventLoopGroup: eventLoopGroup,
                connectionSource: .init(
                    configuration: .init(
                        storage: .memory,
                        enableForeignKeys: true
                    ),
                    threadPool: threadPool
                )
            )
        )

        try await components.run()

        //        setenv("FEATHER_SERVICE_MIGRATOR_LOG_LEVEL", "trace", 1)

        let migrator = Migrator(
            components: components,
            storage: MigrationEntryStorageEphemeral()
        )
        try await migrator.perform(
            groups: [
                SystemMigrationGroup()
            ]
        )

        do {
            let db = try await components.relationalDatabase().connection()

            try await runQueryTests(db)

            try await runSystemAccessTokenModelTest(db)
            try await runSystemPermissionModelTest(db)
            try await runSystemPushMessageModelTest(db)

        }
        catch {
            print("-------------------------------")
            print("\(error)")
            print("-------------------------------")
        }

        try await components.shutdown()
        try await eventLoopGroup.shutdownGracefully()
    }

    func runQueryTests(_ db: SQLDatabase) async throws {

    }
}
