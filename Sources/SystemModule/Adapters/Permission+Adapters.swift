import FeatherModuleKit
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.Permission.Model: CreateAdapter, UpdateAdapter, PatchAdapter {
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

extension System.Permission.Model.ColumnNames: ListQuerySortKeyAdapter {
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

extension System.Permission.List.Item: ListItemAdapter {
    public init(model: System.Permission.Model) throws {
        self.init(key: model.key.toID(), name: model.name)
    }
}

extension System.Permission.List: ListAdapter {
    public typealias Model = System.Permission.Model
}

extension System.Permission.Reference: ReferenceAdapter {
    public init(model: System.Permission.Model) throws {
        self.init(key: model.key.toID(), name: model.name)
    }
}

extension System.Permission.Detail: DetailAdapter {
    public init(model: System.Permission.Model) throws {
        self.init(key: model.key.toID(), name: model.name, notes: model.notes)
    }
}
