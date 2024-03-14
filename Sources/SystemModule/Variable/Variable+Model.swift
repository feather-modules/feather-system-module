import DatabaseQueryKit
import SystemModuleInterface

extension System.Variable {

    struct Model: QueryModel {

        enum CodingKeys: String, QueryFieldKey {
            case key
            case value
            case name
            case notes
        }
        static let fieldKeys = CodingKeys.self

        let key: Key<System.Variable>
        let value: String
        let name: String?
        let notes: String?

        init(
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
