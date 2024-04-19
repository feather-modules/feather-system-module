import FeatherDatabase
import Foundation
import SystemModuleKit

extension System.PushMessage {

    public struct Model: KeyedDatabaseModel {
        public typealias KeyType = Key<System.PushMessage>

        public enum CodingKeys: String, DatabaseColumnName {
            case id
            case title
            case message
            case topic
            case date
            case recipients
        }
        public static var keyName = ColumnNames.id
        public static let columnNames = CodingKeys.self
        public static let tableName = "system_push_message"

        public let id: KeyType
        public let title: String
        public let message: String
        public let topic: String
        public let date: Date
        public let recipients: String?

        public init(
            id: KeyType,
            title: String,
            message: String,
            topic: String,
            date: Date,
            recipients: String? = nil
        ) {
            self.id = id
            self.title = title
            self.message = message
            self.topic = topic
            self.date = date
            self.recipients = recipients
        }
    }
}
