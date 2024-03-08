//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/01/2024.
//

import DatabaseQueryKit
import FeatherRelationalDatabase
import SQLKit
import SystemSDKInterface

extension System.AccessToken {

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
        static var primaryKey = Model.FieldKeys.token
        let db: Database

        static let tableName = "system_access_token"

    }
}
