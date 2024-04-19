//
//  File.swift
//
//
//  Created by Tibor Bodecs on 15/02/2024.
//

import FeatherDatabase
import FeatherModuleKit
import FeatherValidation
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.Variable {

    enum Validators {

        static func uniqueKey(
            _ value: ID<System.Variable>,
            on db: Database,
            _ originalKey: ID<System.Variable>? = nil
        ) -> Validator {
            KeyValueValidator(
                key: "key",
                value: value,
                rules: [
                    .unique(
                        System.Variable.Query.self,
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

        static func value(
            _ value: String
        ) -> Validator {
            KeyValueValidator(
                key: "value",
                value: value,
                rules: [
                    .nonempty()
                ]
            )
        }
    }
}

extension System.Variable.Create {

    func validate(
        on db: Database
    ) async throws {
        let v = GroupValidator {
            System.Variable.Validators.key(key.rawValue)
            System.Variable.Validators.uniqueKey(key, on: db)
            System.Variable.Validators.value(value)
        }
        try await v.validate()
    }
}

extension System.Variable.Update {

    func validate(
        _ originalKey: ID<System.Variable>,
        on db: Database
    ) async throws {
        let v = GroupValidator {
            System.Variable.Validators.key(key.rawValue)
            System.Variable.Validators.uniqueKey(
                key,
                on: db,
                originalKey
            )
            System.Variable.Validators.value(value)
        }
        try await v.validate()
    }
}

extension System.Variable.Patch {

    func validate(
        _ originalKey: ID<System.Variable>,
        on db: Database
    ) async throws {
        let v = GroupValidator {
            if let key {
                System.Variable.Validators.key(key.rawValue)
                System.Variable.Validators.uniqueKey(
                    key,
                    on: db,
                    originalKey
                )
            }
            if let value {
                System.Variable.Validators.value(value)
            }
        }
        try await v.validate()
    }
}
