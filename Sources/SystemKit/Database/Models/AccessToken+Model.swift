import DatabaseQueryKit
import SystemInterfaceKit

extension System.AccessToken {

    struct Model: Codable {

        enum CodingKeys: String, DatabaseQueryCodingKey {
            case token
        }

        let token: String
    }
}
