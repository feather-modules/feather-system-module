import DatabaseQueryKit
import SystemModuleKit

extension System.AccessToken {

    public struct Model: QueryModel {

        public enum CodingKeys: String, QueryFieldKey {
            case token
        }
        public static let fieldKeys = CodingKeys.self

        public let token: String

        public init(token: String) {
            self.token = token
        }
    }
}
