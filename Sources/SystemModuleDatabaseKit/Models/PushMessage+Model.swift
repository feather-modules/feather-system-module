import DatabaseQueryKit
import Foundation
import SystemModuleKit

extension System.PushMessage {

    public struct Model: QueryModel {

        public enum CodingKeys: String, QueryFieldKey {
            case id
            case title
            case message
            case topic
            case date
            case recipients
        }
        public static let fieldKeys = CodingKeys.self

        public let id: UUID
        public let title: String
        public let message: String
        public let topic: String
        public let date: Date
        public let recipients: String?

        public init(
            id: UUID,
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
