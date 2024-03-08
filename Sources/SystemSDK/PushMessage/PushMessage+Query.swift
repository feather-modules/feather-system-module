//
//  File.swift
//
//
//  Created by Tibor Bodecs on 07/01/2024.
//

import DatabaseQueryKit
import FeatherRelationalDatabase
import SQLKit
import SystemSDKInterface

extension System.PushMessage {

    struct Query:
        QueryBuilderSchema,
        QueryBuilderAll,
        QueryBuilderCount,
        QueryBuilderDelete,
        QueryBuilderFirst,
        QueryBuilderInsert,
        QueryBuilderList,
        QueryBuilderPrimaryKey,
        QueryBuilderPrimaryKeyDelete,
        QueryBuilderPrimaryKeyGet,
        QueryBuilderPrimaryKeyUpdate
    {
        typealias Row = Model
        static var primaryKey = Model.FieldKeys.id
        let db: Database

        static let tableName = "system_push_message"
    }
}
