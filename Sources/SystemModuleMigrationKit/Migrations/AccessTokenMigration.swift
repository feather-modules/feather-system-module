import DatabaseMigrationKit
import MigrationKit
import SQLKit
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.AccessToken {

    public enum Migrations {

        public struct V1: RelationalDatabaseTableMigration {
            public let tableName: String

            public init() {
                self.tableName = System.AccessToken.Query.tableName
            }

            public func statements(
                _ builder: SQLCreateTableBuilder
            ) -> SQLCreateTableBuilder {
                builder
                    .text(System.AccessToken.Model.fieldKeys.token.rawValue)
                    .unique(System.AccessToken.Model.fieldKeys.token.rawValue)
            }
        }
    }
}
