//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/01/2024.
//

import FeatherDatabase
import SystemModuleKit

extension System.Permission {

    public struct Model: KeyedDatabaseModel {
        public typealias KeyType = Key<System.Permission>

        public enum CodingKeys: String, DatabaseColumnName {
            case key
            case name
            case notes
        }
        public static let columnNames = CodingKeys.self
        public static let keyName = Model.ColumnNames.key
        public static let tableName = "system_permission"

        public let key: KeyType
        public let name: String
        public let notes: String?

        public init(
            key: KeyType,
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
