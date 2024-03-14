//
//  File.swift
//
//
//  Created by Tibor Bodecs on 04/12/2023.
//

import DatabaseQueryKit
import FeatherRelationalDatabase
import SQLKit
import SystemModuleInterface

extension System.Variable {

    struct Query: StandardQueryBuilderPrimaryKey {
        typealias Row = Model
        static var primaryKey = Model.FieldKeys.key
        let db: Database

        static let tableName = "system_variable"
    }
}
