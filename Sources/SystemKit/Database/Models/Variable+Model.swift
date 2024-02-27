import DatabaseQueryKit
import SystemInterfaceKit

extension System.Variable {

    struct Model: Codable {

        enum CodingKeys: String, DatabaseQueryCodingKey {
            case key
            case value
            case name
            case notes
        }

        let key: String
        let value: String
        let name: String?
        let notes: String?

        init(
            key: String,
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
