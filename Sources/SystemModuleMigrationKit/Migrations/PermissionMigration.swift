import DatabaseMigrationKit
import MigrationKit
import SQLKit

extension SystemMigrationGroup.Version1 {

    public struct Permission: RelationalDatabaseTableMigration {

        public let tableName: String

        public init() {
            self.tableName = "system_permission"
        }

        public func statements(
            _ builder: SQLCreateTableBuilder
        ) -> SQLCreateTableBuilder {
            builder
                .text("key")
                .text("name")
                .text("notes", isMandatory: false)
                .unique("key")
        }
    }
}
