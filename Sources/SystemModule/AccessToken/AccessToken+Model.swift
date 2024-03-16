import DatabaseQueryKit
import SystemModuleKit

extension System.AccessToken {

    struct Model: QueryModel {

        enum CodingKeys: String, QueryFieldKey {
            case token
        }
        static let fieldKeys = CodingKeys.self

        let token: String
    }
}
