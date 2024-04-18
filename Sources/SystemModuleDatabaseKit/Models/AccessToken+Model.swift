import FeatherDatabase
import SystemModuleKit

extension System.AccessToken {

    public struct Model: DatabaseModel {
        public enum CodingKeys: String, DatabaseColumnName {
            case token
        }

        public static let columnNames = CodingKeys.self
        public static let tableName = "system_access_token"

        public let token: String

        public init(token: String) {
            self.token = token
        }
    }
}
