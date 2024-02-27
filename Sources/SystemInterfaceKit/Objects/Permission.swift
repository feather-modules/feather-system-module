import FeatherKit

extension System.Permission {

    public struct Reference: Codable {
        public let key: ID<System.Permission>
        public let name: String

        public init(
            key: ID<System.Permission>,
            name: String
        ) {
            self.key = key
            self.name = name
        }
    }

    public enum List {

        public enum Sort: String, Codable {
            case key
            case name
        }

        public struct Item: Codable {
            public let key: ID<System.Permission>
            public let name: String

            public init(
                key: ID<System.Permission>,
                name: String
            ) {
                self.key = key
                self.name = name
            }
        }
    }

    public struct Detail: Codable {
        public let key: ID<System.Permission>
        public let name: String
        public let notes: String?

        public init(
            key: ID<System.Permission>,
            name: String,
            notes: String?
        ) {
            self.key = key
            self.name = name
            self.notes = notes
        }
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

    public struct Update: Codable {
        public let key: ID<System.Permission>
        public let name: String
        public let notes: String?

        public init(
            key: ID<System.Permission>,
            name: String,
            notes: String?
        ) {
            self.key = key
            self.name = name
            self.notes = notes
        }
    }

}
