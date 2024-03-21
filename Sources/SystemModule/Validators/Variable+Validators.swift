//
//  File.swift
//
//
//  Created by Tibor Bodecs on 15/02/2024.
//

import CoreModule
import CoreModuleKit
import DatabaseQueryKit
import FeatherValidation
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.Variable {

    enum Validators {

        static func uniqueKey(
            _ value: ID<System.Variable>,
            _ queryBuilder: System.Variable.Query,
            _ originalKey: ID<System.Variable>? = nil
        ) -> Validator {
            KeyValueValidator(
                key: "key",
                value: value,
                rules: [
                    .unique(
                        queryBuilder: queryBuilder,
                        fieldKey: .key,
                        originalValue: originalKey
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
        _ queryBuilder: System.Variable.Query
    ) async throws {
        let v = GroupValidator {
            System.Variable.Validators.key(key.rawValue)
            System.Variable.Validators.uniqueKey(key, queryBuilder)
            System.Variable.Validators.value(value)
        }
        try await v.validate()
    }
}

extension System.Variable.Update {

    func validate(
        _ originalKey: ID<System.Variable>,
        _ queryBuilder: System.Variable.Query
    ) async throws {
        let v = GroupValidator {
            System.Variable.Validators.key(key.rawValue)
            System.Variable.Validators.uniqueKey(
                key,
                queryBuilder,
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
        _ queryBuilder: System.Variable.Query
    ) async throws {
        let v = GroupValidator {
            if let key {
                System.Variable.Validators.key(key.rawValue)
                System.Variable.Validators.uniqueKey(
                    key,
                    queryBuilder,
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
