//
//  File.swift
//
//
//  Created by Tibor Bodecs on 15/02/2024.
//

import DatabaseQueryKit
import FeatherValidation
import SystemSDKInterface

extension Rule where T == String {

    static func unique(
        message: String? = nil,
        queryBuilder: any QueryBuilderPrimaryKeyGet
    ) -> Self {
        .init(
            message: message ?? "The value should be unique."
        ) { value in
            guard try await queryBuilder.get(value) == nil else {
                throw RuleError.invalid
            }
        }
    }
}
extension System.Variable {

    enum Validators {

        static func key(
            _ value: String,
            _ queryBuilder: System.Variable.Query
        ) -> Validator {
            KeyValueValidator(
                key: "key",
                value: value,
                rules: [
                    .nonempty(),
                    .min(length: 3),
                    .max(length: 64),
                    .unique(queryBuilder: queryBuilder),
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
