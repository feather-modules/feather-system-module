//
//  File.swift
//
//
//  Created by Tibor Bodecs on 30/01/2024.
//

import DatabaseMigrationKit
import FeatherComponent
import FeatherRelationalDatabase
import FeatherRelationalDatabaseDriverSQLite
import Logging
import MigrationKit
import NIO
import SQLKit
import SystemModuleMigrationKit
import XCTest

extension XCTestCase {

    func runSQLDatabaseTest(
        _ block: ((SQLDatabase) async throws -> Void)
    ) async throws {
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
            try await block(db)
        }
        catch {
            XCTFail("\(error)")
        }

        try await components.shutdown()
        try await eventLoopGroup.shutdownGracefully()
    }
}
