//
//  File.swift
//
//
//  Created by Tibor Bodecs on 21/03/2024.
//

import FeatherDatabase
import SystemModuleDatabaseKit
import SystemModuleKit
import XCTest

@testable import SystemModuleMigrationKit

final class SystemModuleMigrationKitTests: TestCase {

    func testSeedMigration() async throws {
        try await scripts.execute([
            System.Migrations.V1.self
        ])

        let db = try await components.database().connection()

        try await System.Permission.Query
            .insert(
                .init(
                    key: .init(rawValue: "foo.bar.baz"),
                    name: "foo"
                ),
                on: db
            )

        try await System.Variable.Query
            .insert(
                .init(
                    key: .init(rawValue: "foo"),
                    value: "foo"
                ),
                on: db
            )
    }
}
