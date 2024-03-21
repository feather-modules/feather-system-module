//
//  File.swift
//
//
//  Created by Tibor Bodecs on 04/12/2023.
//

import DatabaseQueryKit
import FeatherRelationalDatabase
import SQLKit
import SystemModuleKit

extension System.Variable {

    public struct Query: StandardQueryBuilderPrimaryKey {
        public typealias Row = Model
        public static var primaryKey = Model.FieldKeys.key
        public let db: Database

        public static let tableName = "system_variable"

        public init(db: Database) {
            self.db = db
        }
    }
}
