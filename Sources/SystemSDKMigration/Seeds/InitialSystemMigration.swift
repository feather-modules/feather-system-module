//
//  File.swift
//
//
//  Created by Tibor Bodecs on 27/02/2024.
//

import DatabaseMigrationKit
import MigrationKit
import SQLKit

extension SystemMigrationSeedGroup.Version1 {

    public struct Initial: RelationalDatabaseMigration {

        public let permissions: [PermissionSeed]
        public let variables: [VariableSeed]

        public init(
            permissions: [PermissionSeed] = [],
            variables: [VariableSeed] = []
        ) {
            self.permissions = permissions
            self.variables = variables
        }

        public func perform(_ db: SQLDatabase) async throws {

            if !permissions.isEmpty {
                try await db.insert(
                    into: "system_permission"
                )
                .models(permissions)
                .run()
            }

            if !variables.isEmpty {
                try await db.insert(
                    into: "system_variable"
                )
                .models(variables)
                .run()
            }
        }

        public func revert(_ db: SQLDatabase) async throws {
            // TODO: delete rows
        }

    }
}
