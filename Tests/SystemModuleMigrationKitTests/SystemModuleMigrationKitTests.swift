//
//  File.swift
//
//
//  Created by Tibor Bodecs on 21/03/2024.
//

import DatabaseMigrationKit
import DatabaseQueryKit
import MigrationKit
import SQLKit
import SystemModuleDatabaseKit
import SystemModuleKit
import XCTest

@testable import SystemModuleMigrationKit

struct SeedMigration: RelationalDatabaseMigration {

    func perform(_ db: Database) async throws {

        try await System.Permission.Query(db: db)
            .insert(
                [
                    .init(
                        key: .init(rawValue: "foo.bar.baz"),
                        name: "foo"
                    )
                ]
            )

        try await System.Variable.Query(db: db)
            .insert(
                [
                    .init(
                        key: .init(rawValue: "foo"),
                        value: "foo"
                    )
                ]
            )
    }

    func revert(_ db: Database) async throws {

    }
}

struct MyGroup: MigrationGroup {

    func migrations() -> [Migration] {
        [
            SeedMigration()
        ]
    }
}

final class SystemModuleMigrationKitTests: TestCase {

    func testSeedMigration() async throws {

        try await migrator.perform(
            groups: System.MigrationGroups.all + [
                MyGroup()
            ]
        )
    }
}
