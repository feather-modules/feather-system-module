import DatabaseMigrationKit
import MigrationKit
import SQLKit
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.Permission {

    public enum Migrations {

        public struct V1: RelationalDatabaseTableMigration {

            public let tableName: String

            public init() {
                self.tableName = "system_permission"
            }

            public func statements(
                _ builder: SQLCreateTableBuilder
            ) -> SQLCreateTableBuilder {
                builder
                    .text(Model.fieldKeys.key.rawValue)
                    .text(Model.fieldKeys.name.rawValue)
                    .text(Model.fieldKeys.notes.rawValue, isMandatory: false)
                    .unique(Model.fieldKeys.key.rawValue)
            }
        }
    }
}
