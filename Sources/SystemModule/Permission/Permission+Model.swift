//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/01/2024.
//

import DatabaseQueryKit
import SystemModuleInterface

extension System.Permission {

    struct Model: QueryModel {

        enum CodingKeys: String, QueryFieldKey {
            case key
            case name
            case notes
        }
        static let fieldKeys = CodingKeys.self

        let key: Key<System.Permission>
        let name: String
        let notes: String?

        init(
            key: Key<System.Permission>,
            name: String,
            notes: String? = nil
        ) {
            precondition(
                key.rawValue.split(separator: ".").count == 3,
                "Key must contain 3 parts separated by a `.` character."
            )
            self.key = key
            self.name = name
            self.notes = notes
        }
    }
}

extension System.Permission.Model {
    var namespace: String { .init(key.rawValue.split(separator: ".")[0]) }
    var context: String { .init(key.rawValue.split(separator: ".")[1]) }
    var action: String { .init(key.rawValue.split(separator: ".")[2]) }
}
