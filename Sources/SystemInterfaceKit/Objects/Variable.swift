import FeatherKit

extension System.Variable {

    public struct Reference: Codable {
        public let key: ID<System.Variable>
        public let value: String

        public init(
            key: ID<System.Variable>,
            value: String
        ) {
            self.key = key
            self.value = value
        }
    }

    // MARK: -

    public enum List {

        public enum Sort: String, Codable {
            case key
            case value
            case name
        }

        public struct Item: Codable {
            public let key: ID<System.Variable>
            public let value: String
            public let name: String?

            public init(
                key: ID<System.Variable>,
                value: String,
                name: String?
            ) {
                self.key = key
                self.value = value
                self.name = name
            }
        }
    }

    // MARK: -

    public struct Detail: Codable {
        public let key: ID<System.Variable>
        public let value: String
        public let name: String?
        public let notes: String?

        public init(
            key: ID<System.Variable>,
            value: String,
            name: String?,
            notes: String?
        ) {
            self.key = key
            self.value = value
            self.name = name
            self.notes = notes
        }
    }

    // MARK: -

    public struct Create: Codable {
        public let key: ID<System.Variable>
        public let value: String
        public let name: String?
        public let notes: String?

        public init(
            key: ID<System.Variable>,
            value: String,
            name: String?,
            notes: String?
        ) {
            self.key = key
            self.value = value
            self.name = name
            self.notes = notes
        }
    }

    // MARK: -

    public struct Update: Codable {
        public let key: ID<System.Variable>
        public let value: String
        public let name: String?
        public let notes: String?

        public init(
            key: ID<System.Variable>,
            value: String,
            name: String?,
            notes: String?
        ) {
            self.key = key
            self.value = value
            self.name = name
            self.notes = notes
        }
    }

    // MARK: -

    public struct Patch: Codable {
        public let key: ID<System.Variable>?
        public let value: String?
        public let name: String?
        public let notes: String?

        public init(
            key: ID<System.Variable>?,
            value: String?,
            name: String?,
            notes: String?
        ) {
            self.key = key
            self.value = value
            self.name = name
            self.notes = notes
        }
    }

}
