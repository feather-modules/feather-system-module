//
//  File.swift
//
//
//  Created by Tibor Bodecs on 13/03/2024.
//

import CoreModule
import CoreModuleInterface
import DatabaseQueryKit
import FeatherValidation
import SystemModuleInterface

extension System.Permission {

    enum Validators {

        static func uniqueKey(
            _ value: ID<System.Permission>,
            _ queryBuilder: System.Permission.Query,
            _ originalKey: ID<System.Permission>? = nil
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
    }
}

extension System.Permission.Create {

    func validate(
        _ queryBuilder: System.Permission.Query
    ) async throws {
        let v = GroupValidator {
            System.Permission.Validators.key(key.rawValue)
            System.Permission.Validators.uniqueKey(key, queryBuilder)
        }
        try await v.validate()
    }
}

extension System.Permission.Update {

    func validate(
        _ originalKey: ID<System.Permission>,
        _ queryBuilder: System.Permission.Query
    ) async throws {
        let v = GroupValidator {
            System.Permission.Validators.key(key.rawValue)
            System.Permission.Validators.uniqueKey(
                key,
                queryBuilder,
                originalKey
            )
        }
        try await v.validate()
    }
}

extension System.Permission.Patch {

    func validate(
        _ originalKey: ID<System.Permission>,
        _ queryBuilder: System.Permission.Query
    ) async throws {
        let v = GroupValidator {
            if let key {
                System.Permission.Validators.key(key.rawValue)
                System.Permission.Validators.uniqueKey(
                    key,
                    queryBuilder,
                    originalKey
                )
            }
        }
        try await v.validate()
    }
}
