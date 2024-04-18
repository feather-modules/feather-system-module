import FeatherDatabase
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.Variable {

    public enum Table: DatabaseTable {
        public static let tableName = Model.tableName
        public static let columns: [DatabaseColumnInterface] = [
            StringColumn(Model.ColumnNames.key),
            StringColumn(Model.ColumnNames.value),
            StringColumn(Model.ColumnNames.name, isMandatory: false),
            StringColumn(Model.ColumnNames.notes, isMandatory: false),
        ]
        public static let constraints: [DatabaseConstraintInterface] = [
            PrimaryKeyConstraint(Model.ColumnNames.key)
        ]
    }
}
