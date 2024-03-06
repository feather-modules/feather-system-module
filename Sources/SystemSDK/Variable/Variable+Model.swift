import DatabaseQueryKit
import SystemSDKInterface

extension System.Variable {

    struct Model: Codable {

        enum CodingKeys: String, DatabaseQueryCodingKey {
            case key
            case value
            case name
            case notes
        }

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
