import DatabaseQueryKit
import SystemModuleKit

extension System.Variable {

    public struct Model: QueryModel {

        public enum CodingKeys: String, QueryFieldKey {
            case key
            case value
            case name
            case notes
        }
        public static let fieldKeys = CodingKeys.self

        public let key: Key<System.Variable>
        public let value: String
        public let name: String?
        public let notes: String?

        public init(
            key: Key<System.Variable>,
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
}
