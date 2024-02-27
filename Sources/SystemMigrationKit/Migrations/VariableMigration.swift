import DatabaseMigrationKit
import MigrationKit
import SQLKit

extension SystemMigrationGroup.Version1 {

    public struct Variable: RelationalDatabaseTableMigration {

        public let tableName: String

        public init() {
            self.tableName = "system_variable"
        }

        public func statements(
            _ builder: SQLCreateTableBuilder
        ) -> SQLCreateTableBuilder {
            builder
                .text("key")
                .text("value")
                .text("name", isMandatory: false)
                .text("notes", isMandatory: false)
                .unique("key")
        }
    }
}
