//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

import CoreSDKInterface

extension System.Variable {

    public struct Reference: SystemVariableReference {
        public let key: ID<System.Variable>
        public let value: String

        public init(key: ID<System.Variable>, value: String) {
            self.key = key
            self.value = value
        }
    }

    public struct List: SystemVariableList {
        public struct Query: SystemVariableListQuery {
            public struct Sort: SystemVariableListSort {
                public let by: SystemVariableListSortKeys
                public let order: Order

                public init(by: SystemVariableListSortKeys, order: Order) {
                    self.by = by
                    self.order = order
                }
            }

            public let search: String?
            public let sort: Sort
            public let page: Page

            public init(
                search: String? = nil,
                sort: System.Variable.List.Query.Sort,
                page: Page
            ) {
                self.search = search
                self.sort = sort
                self.page = page
            }
        }

        public struct Item: SystemVariableListItem, Equatable, Hashable {
            public let key: ID<System.Variable>
            public let value: String

            public init(key: ID<System.Variable>, value: String) {
                self.key = key
                self.value = value
            }
        }

        public let items: [Item]
        public let query: Query
        public let page: Page
        public let count: UInt

        public init(
            items: [System.Variable.List.Item],
            query: System.Variable.List.Query,
            page: Page,
            count: UInt
        ) {
            self.items = items
            self.query = query
            self.page = page
            self.count = count
        }

    }

    public struct Detail: SystemVariableDetail {
        public let key: ID<System.Variable>
        public let value: String
        public let name: String?
        public let notes: String?

        public init(
            key: ID<System.Variable>,
            value: String,
            name: String? = nil,
            notes: String? = nil
        ) {
            self.key = key
            self.value = value
            self.name = name
            self.notes = notes
        }
    }

    public struct Create: SystemVariableCreate {
        public let key: ID<System.Variable>
        public let value: String
        public let name: String?
        public let notes: String?

        public init(
            key: ID<System.Variable>,
            value: String,
            name: String? = nil,
            notes: String? = nil
        ) {
            self.key = key
            self.value = value
            self.name = name
            self.notes = notes
        }
    }

    public struct Update: SystemVariableUpdate {
        public let key: ID<System.Variable>
        public let value: String
        public let name: String?
        public let notes: String?

        public init(
            key: ID<System.Variable>,
            value: String,
            name: String? = nil,
            notes: String? = nil
        ) {
            self.key = key
            self.value = value
            self.name = name
            self.notes = notes
        }
    }

    public struct Patch: SystemVariablePatch {
        public let key: ID<System.Variable>?
        public let value: String?
        public let name: String?
        public let notes: String?

        public init(
            key: ID<System.Variable>? = nil,
            value: String? = nil,
            name: String? = nil,
            notes: String? = nil
        ) {
            self.key = key
            self.value = value
            self.name = name
            self.notes = notes
        }
    }
}
