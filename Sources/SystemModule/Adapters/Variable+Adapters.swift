import FeatherComponent
import FeatherDatabase
import FeatherModuleKit
import FeatherValidation
import NanoID
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.Variable.Model: ModelInterfaceCreate, ModelInterfaceUpdate,
    ModelInterfacePatch
{
    public init(create: System.Variable.Create) {
        self.init(
            key: create.key.toKey(),
            value: create.value,
            name: create.name,
            notes: create.notes
        )
    }

    public init(update: System.Variable.Update, oldModel: Self) {
        self.init(
            key: update.key.toKey(),
            value: update.value,
            name: update.name,
            notes: update.notes
        )
    }

    public init(patch: System.Variable.Patch, oldModel: Self) {
        self.init(
            key: patch.key?.toKey() ?? oldModel.key,
            value: patch.value ?? oldModel.value,
            name: patch.name ?? oldModel.name,
            notes: patch.notes ?? oldModel.notes
        )
    }
}

extension System.Variable.Model.ColumnNames: ModelColumnNamesInterface {
    public init(listQuerySortKeys: System.Variable.List.Query.Sort.Key) {
        switch listQuerySortKeys {
        case .key:
            self = .key
        case .name:
            self = .name
        case .value:
            self = .value
        }
    }
}

extension System.Variable.List: ListInterface {
    public init(items: [System.Variable.Model], count: UInt) throws {
        self.init(
            items: items.map {
                .init(key: $0.key.toID(), value: $0.value, name: $0.name)
            },
            count: count
        )
    }
}

extension System.Variable.List.Query: ListQueryInterface {}

extension System.Variable.List.Query.Sort: ListQuerySortInterface {}

extension System.Variable.Reference: ReferenceInterface {
    public init(model: System.Variable.Model) throws {
        self.init(key: model.key.toID(), value: model.value)
    }
}

extension System.Variable.Detail: DetailInterface {
    public init(model: System.Variable.Model) throws {
        self.init(
            key: model.key.toID(),
            value: model.value,
            name: model.name,
            notes: model.notes
        )
    }
}

extension System.Variable.Create: CreateInterface {}

extension System.Variable.Update: UpdateInterface {}

extension System.Variable.Patch: PatchInterface {}
