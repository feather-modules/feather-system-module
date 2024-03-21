import DatabaseMigrationKit
import MigrationKit
import SystemModuleDatabaseKit
import SystemModuleKit

extension System {

    public enum MigrationGroups {

        public static var all: [MigrationGroup] {
            [
                Structural()
            ]
        }

        public struct Structural: MigrationGroup {

            public init() {}

            public func migrations() -> [Migration] {
                [
                    Permission.Migrations.V1(),
                    Variable.Migrations.V1(),
                ]
            }
        }
    }
}
