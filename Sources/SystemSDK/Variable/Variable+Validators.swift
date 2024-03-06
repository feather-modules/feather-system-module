//
//  File.swift
//
//
//  Created by Tibor Bodecs on 15/02/2024.
//

import FeatherValidation
import SQLKit
import SystemSDKInterface

extension System.Variable {

    enum Validators {

        static func key(_ value: String) -> Validator {
            KeyValueValidator(
                key: "key",
                value: value,
                invocation: .all,
                rules: [
                    .nonempty(),
                    .min(length: 3),
                    .max(length: 64),
                    // TODO: unique
                    //                    .init(
                    //                        message: "ouch",
                    //                        { value in
                    //                            guard try await System.Variable.Query(db: db).firstBy(key: .key, value: value) == nil else {
                    //                                throw RuleError.invalid
                    //                            }
                    ////                            throw RuleError.invalid
                    //                        }
                    //                    ),
                ]
            )
        }
    }
}

//extension SystemVariableCreate {
//
//    func validate() async throws {
//        let v = GroupValidator {
//            SystemVariableValidators.key(key.rawValue)
//        }
//        try await v.validate()
//    }
//}
