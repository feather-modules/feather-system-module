//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

import CoreSDKInterface

extension System.Permission {

    public struct Reference: Codable {
        public let key: ID<System.Permission>
        public let name: String

        public init(key: ID<System.Permission>, name: String) {
            self.key = key
            self.name = name
        }
    }

    public struct List: CoreSDKInterface.List {
        public typealias Item = _Item

        public struct Query: Sendable, Equatable, Hashable, Codable {

            public struct Sort: Sendable, Equatable, Hashable, Codable {
                
                public enum SortKeys: SortKeyInterface {
                    case key
                    case name
                }
                
                public let by: SortKeys
                public let order: Order

                public init(by: SortKeys, order: Order) {
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

        public struct _Item: Sendable, Equatable, Hashable, Codable {
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

    public struct Detail: Codable {
        public let key: ID<System.Permission>
        public let name: String
        public let notes: String?
    }

    public struct Create: Codable {
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

    public struct Update: Codable {
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

    public struct Patch: Codable {
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
