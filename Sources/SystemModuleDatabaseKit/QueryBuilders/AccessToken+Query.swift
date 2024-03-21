//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/01/2024.
//

import DatabaseQueryKit
import FeatherRelationalDatabase
import SQLKit
import SystemModuleKit

extension System.AccessToken {

    public struct Query: StandardQueryBuilderPrimaryKey {
        public typealias Row = Model
        public static var primaryKey = Model.FieldKeys.token
        public let db: Database

        public static let tableName = "system_access_token"

        public init(db: Database) {
            self.db = db
        }

    }
}
