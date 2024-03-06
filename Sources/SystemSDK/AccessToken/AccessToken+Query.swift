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
        InsertQueryBuilder,
        SelectQueryBuilder,
        ListQueryBuilder
    {
        typealias Row = Model
        typealias FieldKeys = Row.CodingKeys

        static let tableName = "system_access_token"
        let db: SQLDatabase
    }
}
