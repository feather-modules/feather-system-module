//
//  File.swift
//
//
//  Created by Tibor Bodecs on 13/03/2024.
//

import FeatherDatabase
import FeatherModuleKit
import FeatherValidation
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.Permission {

    enum Validators {

        static func uniqueKey(
            _ value: ID<System.Permission>,
            on db: Database,
            _ originalKey: ID<System.Permission>? = nil
        ) -> Validator {
            KeyValueValidator(
                key: "key",
                value: value,
                rules: [
                    .unique(
                        Query.self,
                        column: .key,
                        originalValue: originalKey,
                        on: db
                    )
                ]
            )
        }

        static func key(
            _ value: String
        ) -> Validator {
            KeyValueValidator(
                key: "key",
                value: value,
                rules: [
                    .nonempty(),
                    .min(length: 3),
                    .max(length: 64),
                ]
            )
        }
    }
}

extension System.Permission.Create {

    public func validate(
        on db: Database
    ) async throws {
        let v = GroupValidator {
            System.Permission.Validators.key(key.rawValue)
            System.Permission.Validators.uniqueKey(key, on: db)
        }
        try await v.validate()
    }
}

extension System.Permission.Update {

    public func validate(
        _ originalKey: ID<System.Permission>,
        on db: Database
    ) async throws {
        let v = GroupValidator {
            System.Permission.Validators.key(key.rawValue)
            System.Permission.Validators.uniqueKey(
                key,
                on: db,
                originalKey
            )
        }
        try await v.validate()
    }
}

extension System.Permission.Patch {

    public func validate(
        _ originalKey: ID<System.Permission>,
        on db: Database
    ) async throws {
        let v = GroupValidator {
            if let key {
                System.Permission.Validators.key(key.rawValue)
                System.Permission.Validators.uniqueKey(
                    key,
                    on: db,
                    originalKey
                )
            }
        }
        try await v.validate()
    }
}
