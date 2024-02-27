//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/02/2024.
//

import DatabaseMigrationKit
import MigrationKit
import SQLKit

public struct SystemMigrationSeedGroup: MigrationGroup {

    public let permissions: [PermissionSeed]
    public let variables: [VariableSeed]

    public init(
        permissions: [PermissionSeed] = [],
        variables: [VariableSeed] = []
    ) {
        self.permissions = permissions
        self.variables = variables
    }

    public func migrations() -> [Migration] {
        [
            Version1.Initial(
                permissions: permissions,
                variables: variables
            )
        ]
    }
}

extension SystemMigrationSeedGroup {
    enum Version1 {}
}
