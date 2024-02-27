//
//  File.swift
//
//
//  Created by Tibor Bodecs on 07/01/2024.
//

import DatabaseQueryKit
import FeatherRelationalDatabase
import SQLKit
import SystemInterfaceKit

extension System.PushMessage {

    struct Query:
        InsertQueryBuilder,
        SelectQueryBuilder,
        ListQueryBuilder
    {
        typealias Row = Model
        typealias FieldKeys = Row.CodingKeys

        static let tableName = "system_push_message"
        let db: SQLDatabase
    }
}
