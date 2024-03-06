//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

import CoreSDKInterface
import SystemSDKInterface

extension System.Permission {

    struct Reference: SystemPermissionReference {
        let key: ID<System.Permission>
        let name: String
    }

    struct List: SystemPermissionList {

        struct Query: SystemPermissionListQuery {

            struct Sort: SystemPermissionListSort {
                let by: SystemPermissionListSortKeys
                let order: Order
            }

            let search: String?
            let sort: Sort
            let page: Page
        }

        struct Item: SystemPermissionListItem, Equatable, Hashable {
            let key: ID<System.Permission>
            let name: String
        }

        let items: [Item]
        let query: Query
        let page: Page
        let count: UInt

    }

    struct Detail: SystemPermissionDetail {
        let key: ID<System.Permission>
        let name: String
        let notes: String?
    }

    struct Create: SystemPermissionCreate {
        let key: ID<System.Permission>
        let name: String
        let notes: String?
    }

    struct Update: SystemPermissionUpdate {
        let key: ID<System.Permission>
        let name: String
        let notes: String?
    }

    struct Patch: SystemPermissionPatch {
        let key: ID<System.Permission>?
        let name: String?
        let notes: String?
    }
}
