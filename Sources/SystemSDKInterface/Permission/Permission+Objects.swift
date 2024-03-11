//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

import CoreSDKInterface

extension System.Permission {

    public struct Reference: Object {
        public let key: ID<System.Permission>
        public let name: String

        public init(key: ID<System.Permission>, name: String) {
            self.key = key
            self.name = name
        }
    }

    public struct List: CoreSDKInterface.List {

        public struct Query: Object {

            public struct Sort: Object {

                public enum Keys: SortKeyInterface {
                    case key
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
                sort: System.Permission.List.Query.Sort,
                page: Page
            ) {
                self.search = search
                self.sort = sort
                self.page = page
            }
        }

        public struct Item: Object {
            public let key: ID<System.Permission>
            public let name: String

            public init(key: ID<System.Permission>, name: String) {
                self.key = key
                self.name = name
            }
        }

        public let items: [Item]
        public let count: UInt

        public init(
            items: [System.Permission.List.Item],
            count: UInt
        ) {
            self.items = items
            self.count = count
        }

    }

    public struct Detail: Object {
        public let key: ID<System.Permission>
        public let name: String
        public let notes: String?
    }

    public struct Create: Object {
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

    public struct Update: Object {
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

    public struct Patch: Object {
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
