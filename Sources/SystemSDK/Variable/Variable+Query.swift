//
//  File.swift
//
//
//  Created by Tibor Bodecs on 04/12/2023.
//

import DatabaseQueryKit
import FeatherRelationalDatabase
import SQLKit
import SystemSDKInterface

extension System.Variable {

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
        static var primaryKey = Model.FieldKeys.key
        let db: Database
        
        static let tableName = "system_variable"
    }
}
