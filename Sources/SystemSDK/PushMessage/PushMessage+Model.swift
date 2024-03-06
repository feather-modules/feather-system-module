import DatabaseQueryKit
import Foundation
import SystemSDKInterface

extension System {
    enum PushMessage {}
}

extension System.PushMessage {

    struct Model: Codable {

        enum CodingKeys: String, DatabaseQueryCodingKey {
            case id
            case title
            case message
            case topic
            case date
            case recipients
        }

        let id: UUID
        let title: String
        let message: String
        let topic: String
        let date: Date
        let recipients: String?

        init(
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
