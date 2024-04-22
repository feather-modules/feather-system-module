import FeatherModuleKit
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.Permission.Model: ModelInterfaceCreate, ModelInterfaceUpdate,
    ModelInterfacePatch
{
    public init(create: System.Permission.Create) throws {
        self.init(
            key: create.key.toKey(),
            name: create.name,
            notes: create.notes
        )
    }

    public init(update: System.Permission.Update, oldModel: Self) throws {
        self.init(
            key: update.key.toKey(),
            name: update.name,
            notes: update.notes
        )
    }

    public init(patch: System.Permission.Patch, oldModel: Self) throws {
        self.init(
            key: patch.key?.toKey() ?? oldModel.key,
            name: patch.name ?? oldModel.name,
            notes: patch.notes ?? oldModel.notes
        )
    }
}

extension System.Permission.Model.ColumnNames: ModelColumnNamesInterface {
    public init(listQuerySortKeys: System.Permission.List.Query.Sort.Key) throws
    {
        switch listQuerySortKeys {
        case .key:
            self = .key
        case .name:
            self = .name
        }
    }
}

extension System.Permission.List: ListInterface {
    public init(items: [System.Permission.Model], count: UInt) throws {
        self.init(
            items: items.map {
                .init(key: $0.key.toID(), name: $0.name)
            },
            count: count
        )
    }
}

extension System.Permission.List.Query: ListQueryInterface {}

extension System.Permission.List.Query.Sort: ListQuerySortInterface {}

extension System.Permission.Reference: ReferenceInterface {
    public init(model: System.Permission.Model) throws {
        self.init(key: model.key.toID(), name: model.name)
    }
}

extension System.Permission.Detail: DetailInterface {
    public init(model: System.Permission.Model) throws {
        self.init(key: model.key.toID(), name: model.name, notes: model.notes)
    }
}

extension System.Permission.Create: CreateInterface {}

extension System.Permission.Update: UpdateInterface {}

extension System.Permission.Patch: PatchInterface {}

extension System.Permission: ControllerModelInterface {}
