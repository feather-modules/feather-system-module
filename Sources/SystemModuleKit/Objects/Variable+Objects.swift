//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

import FeatherModuleKit

extension System.Variable {

    public struct Reference: Object {
        public let key: ID<System.Variable>
        public let value: String

        public init(key: ID<System.Variable>, value: String) {
            self.key = key
            self.value = value
        }
    }

    public struct List: FeatherModuleKit.List {

        public struct Query: ListQueryInterface {

            public struct Sort: ListQuerySortInterface {

                public enum Keys: SortKeyInterface {
                    case key
                    case value
                    case name
                }

                public let by: Keys
                public let order: Order

                public init(by: Keys, order: Order) {
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

        public struct Item: Object {
            public let key: ID<System.Variable>
            public let value: String
            public let name: String?

            public init(key: ID<System.Variable>, value: String, name: String?)
            {
                self.key = key
                self.value = value
                self.name = name
            }
        }

        public let items: [Item]
        public let count: UInt

        public init(
            items: [System.Variable.List.Item],
            count: UInt
        ) {
            self.items = items
            self.count = count
        }

    }

    public struct Detail: Object {
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

    public struct Create: Object {
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

    public struct Update: Object {
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

    public struct Patch: Object {
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
