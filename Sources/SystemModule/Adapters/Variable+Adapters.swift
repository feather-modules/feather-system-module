import FeatherComponent
import FeatherDatabase
import FeatherModuleKit
import FeatherValidation
import NanoID
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.Variable.Model: CreateAdapter, UpdateAdapter, PatchAdapter {
    public init(create: System.Variable.Create) throws {
        self.init(
            key: create.key.toKey(),
            value: create.value,
            name: create.name,
            notes: create.notes
        )
    }

    public init(update: System.Variable.Update, oldModel: Self) throws {
        self.init(
            key: update.key.toKey(),
            value: update.value,
            name: update.name,
            notes: update.notes
        )
    }

    public init(patch: System.Variable.Patch, oldModel: Self) throws {
        self.init(
            key: patch.key?.toKey() ?? oldModel.key,
            value: patch.value ?? oldModel.value,
            name: patch.name ?? oldModel.name,
            notes: patch.notes ?? oldModel.notes
        )
    }
}

extension System.Variable.Model.ColumnNames: ColumnNamesAdapter {
    public init(listQuerySortKeys: System.Variable.List.Query.Sort.Key) throws {
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

extension System.Variable.List.Item: ListItemAdapter {
    public init(model: System.Variable.Model) throws {
        self.init(key: model.key.toID(), value: model.value, name: model.name)
    }
}

extension System.Variable.List: ListAdapter {
    public typealias Model = System.Variable.Model
}

extension System.Variable.Reference: ReferenceAdapter {
    public init(model: System.Variable.Model) throws {
        self.init(key: model.key.toID(), value: model.value)
    }
}

extension System.Variable.Detail: DetailAdapter {
    public init(model: System.Variable.Model) throws {
        self.init(
            key: model.key.toID(),
            value: model.value,
            name: model.name,
            notes: model.notes
        )
    }
}
