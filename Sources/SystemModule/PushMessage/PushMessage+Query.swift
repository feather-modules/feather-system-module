//
//  File.swift
//
//
//  Created by Tibor Bodecs on 07/01/2024.
//

import DatabaseQueryKit
import FeatherRelationalDatabase
import SQLKit
import SystemModuleInterface

extension System.PushMessage {

    struct Query: StandardQueryBuilderPrimaryKey {
        typealias Row = Model
        static var primaryKey = Model.FieldKeys.id
        let db: Database

        static let tableName = "system_push_message"
    }
}
