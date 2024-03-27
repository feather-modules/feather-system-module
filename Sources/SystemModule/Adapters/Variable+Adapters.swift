import CoreModule
import CoreModuleKit
import DatabaseQueryKit
import FeatherComponent
import FeatherValidation
import NanoID
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.Variable.Model {

    func toReference() throws -> System.Variable.Reference {
        .init(key: key.toID(), value: value)
    }

    func toListItem() throws -> System.Variable.List.Item {
        .init(key: key.toID(), value: value)
    }

    func toDetail() throws -> System.Variable.Detail {
        .init(key: key.toID(), value: value, name: name, notes: notes)
    }
}
