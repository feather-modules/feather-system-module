import DatabaseMigrationKit
import MigrationKit
import SQLKit

extension SystemMigrationGroup.Version1 {

    public struct PushMessage: RelationalDatabaseTableMigration {

        public let tableName: String

        public init() {
            self.tableName = "system_push_message"
        }

        public func statements(
            _ builder: SQLCreateTableBuilder
        ) -> SQLCreateTableBuilder {
            builder
                .primaryId()
                .text("title")
                .text("message")
                .text("topic")
                .date("date")
                .text("recipients", isMandatory: false)
        }
    }
}
