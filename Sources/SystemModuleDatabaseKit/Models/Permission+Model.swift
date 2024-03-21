//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/01/2024.
//

import DatabaseQueryKit
import SystemModuleKit

extension System.Permission {

    public struct Model: QueryModel {

        public enum CodingKeys: String, QueryFieldKey {
            case key
            case name
            case notes
        }
        public static let fieldKeys = CodingKeys.self

        public let key: Key<System.Permission>
        public let name: String
        public let notes: String?

        public init(
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
    public var namespace: String {
        .init(key.rawValue.split(separator: ".")[0])
    }
    public var context: String { .init(key.rawValue.split(separator: ".")[1]) }
    public var action: String { .init(key.rawValue.split(separator: ".")[2]) }
}
