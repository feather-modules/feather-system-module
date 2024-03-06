//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

import CoreSDKInterface
import SystemSDKInterface

extension System.Variable {

    struct Reference: SystemVariableReference {
        let key: ID<System.Variable>
        let value: String
    }

    struct List: SystemVariableList {

        struct Query: SystemVariableListQuery {

            struct Sort: SystemVariableListSort {
                let by: SystemVariableListSortKeys
                let order: Order
            }

            let search: String?
            let sort: Sort
            let page: Page
        }

        struct Item: SystemVariableListItem, Equatable, Hashable {
            let key: ID<System.Variable>
            let value: String
        }

        let items: [Item]
        let query: Query
        let page: Page
        let count: UInt

    }

    struct Detail: SystemVariableDetail {
        let key: ID<System.Variable>
        let value: String
        let name: String?
        let notes: String?
    }

    struct Create: SystemVariableCreate {
        let key: ID<System.Variable>
        let value: String
        let name: String?
        let notes: String?
    }

    struct Update: SystemVariableUpdate {
        let key: ID<System.Variable>
        let value: String
        let name: String?
        let notes: String?
    }

    struct Patch: SystemVariablePatch {
        let key: ID<System.Variable>?
        let value: String?
        let name: String?
        let notes: String?
    }
}
