//
//  File.swift
//
//
//  Created by Tibor Bodecs on 15/02/2024.
//

import CoreSDKInterface
import DatabaseQueryKit
import FeatherValidation
import SystemSDKInterface

extension Rule where T == String {

    static func unique(
        message: String? = nil,
        queryBuilder: System.Variable.Query,
        originalKey: ID<System.Variable>? = nil
    ) -> Self {
        .init(
            message: message ?? "The value should be unique."
        ) { value in
            let count = try await queryBuilder.count(.key, .equal, value)
            if let originalKey {
                if originalKey.rawValue == value {
                    guard count == 1 else {
                        throw RuleError.invalid
                    }
                }
                else {
                    guard count == 0 else {
                        throw RuleError.invalid
                    }
                }
            }
            else {
                guard count == 0 else {
                    throw RuleError.invalid
                }
            }
        }
    }
}
extension System.Variable {

    enum Validators {

        static func key(
            _ value: String,
            _ queryBuilder: System.Variable.Query,
            _ originalKey: ID<System.Variable>? = nil
        ) -> Validator {
            KeyValueValidator(
                key: "key",
                value: value,
                rules: [
                    .nonempty(),
                    .min(length: 3),
                    .max(length: 64),
                    .unique(
                        queryBuilder: queryBuilder,
                        originalKey: originalKey
                    ),
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
            System.Variable.Validators.key(key.rawValue, queryBuilder)
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
            System.Variable.Validators.key(
                key.rawValue,
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
                System.Variable.Validators.key(
                    key.rawValue,
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
