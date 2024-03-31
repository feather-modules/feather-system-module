import DatabaseQueryKit
import FeatherComponent
import FeatherModuleKit
import FeatherValidation
import NanoID
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.Permission.Model {

    func toReference() throws -> System.Permission.Reference {
        .init(key: key.toID(), name: name)
    }

    func toListItem() throws -> System.Permission.List.Item {
        .init(key: key.toID(), name: name)
    }

    func toDetail() throws -> System.Permission.Detail {
        .init(key: key.toID(), name: name, notes: notes)
    }
}
