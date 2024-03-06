//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

import CoreSDKInterface

extension System.Permission {

    public struct Reference: SystemPermissionReference {
        public let key: ID<System.Permission>
        public let name: String

        public init(key: ID<System.Permission>, name: String) {
            self.key = key
            self.name = name
        }
    }

    public struct List: SystemPermissionList {
        public struct Query: SystemPermissionListQuery {
            public struct Sort: SystemPermissionListSort {
                public let by: SystemPermissionListSortKeys
                public let order: Order

                public init(by: SystemPermissionListSortKeys, order: Order) {
                    self.by = by
                    self.order = order
                }
            }

            public let search: String?
            public let sort: Sort
            public let page: Page

            public init(
                search: String? = nil,
                sort: System.Permission.List.Query.Sort,
                page: Page
            ) {
                self.search = search
                self.sort = sort
                self.page = page
            }
        }

        public struct Item: SystemPermissionListItem, Equatable, Hashable {
            public let key: ID<System.Permission>
            public let name: String

            public init(key: ID<System.Permission>, name: String) {
                self.key = key
                self.name = name
            }
        }

        public let items: [Item]
        public let query: Query
        public let page: Page
        public let count: UInt

        public init(
            items: [System.Permission.List.Item],
            query: System.Permission.List.Query,
            page: Page,
            count: UInt
        ) {
            self.items = items
            self.query = query
            self.page = page
            self.count = count
        }

    }

    public struct Detail: SystemPermissionDetail {
        public let key: ID<System.Permission>
        public let name: String
        public let notes: String?
    }

    public struct Create: SystemPermissionCreate {
        public let key: ID<System.Permission>
        public let name: String
        public let notes: String?

        public init(
            key: ID<System.Permission>,
            name: String,
            notes: String? = nil
        ) {
            self.key = key
            self.name = name
            self.notes = notes
        }
    }

    public struct Update: SystemPermissionUpdate {
        public let key: ID<System.Permission>
        public let name: String
        public let notes: String?

        public init(
            key: ID<System.Permission>,
            name: String,
            notes: String? = nil
        ) {
            self.key = key
            self.name = name
            self.notes = notes
        }
    }

    public struct Patch: SystemPermissionPatch {
        public let key: ID<System.Permission>?
        public let name: String?
        public let notes: String?

        public init(
            key: ID<System.Permission>? = nil,
            name: String? = nil,
            notes: String? = nil
        ) {
            self.key = key
            self.name = name
            self.notes = notes
        }
    }
}
