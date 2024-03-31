import DatabaseMigrationKit
import MigrationKit
import SQLKit
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.PushMessage {

    public enum Migrations {

        public struct V1: RelationalDatabaseTableMigration {

            public let tableName: String

            public init() {
                self.tableName = "system_push_message"
            }

            public func statements(
                _ builder: SQLCreateTableBuilder
            ) -> SQLCreateTableBuilder {
                builder
                    .primaryId()
                    .text(Model.fieldKeys.title.rawValue)
                    .text(Model.fieldKeys.message.rawValue)
                    .text(Model.fieldKeys.topic.rawValue)
                    .date(Model.fieldKeys.date.rawValue)
                    .text(
                        Model.fieldKeys.recipients.rawValue,
                        isMandatory: false
                    )
            }
        }
    }
}
