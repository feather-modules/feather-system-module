import DatabaseMigrationKit
import MigrationKit
import SQLKit

extension SystemMigrationGroup.Version1 {

    public struct AccessToken: RelationalDatabaseTableMigration {

        public let tableName: String

        public init() {
            self.tableName = "system_access_token"
        }

        public func statements(
            _ builder: SQLCreateTableBuilder
        ) -> SQLCreateTableBuilder {
            builder
                .text("token")
                .unique("token")
        }
    }
}
