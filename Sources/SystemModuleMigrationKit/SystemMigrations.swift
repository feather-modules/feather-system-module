import FeatherComponent
import FeatherDatabase
import FeatherScripts
import SystemModuleDatabaseKit
import SystemModuleKit

extension System {

    public enum Migrations {

        public enum V1: Script {

            public static func run(
                _ components: ComponentRegistry
            ) async throws {
                let db = try await components.database().connection()

                try await Permission.Table.create(on: db)
                try await Variable.Table.create(on: db)
                try await AccessToken.Table.create(on: db)
                try await PushMessage.Table.create(on: db)
            }
        }
    }
}
