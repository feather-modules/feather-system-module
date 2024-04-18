import FeatherDatabase
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.PushMessage {

    public enum Table: DatabaseTable {
        public static let tableName = Model.tableName
        public static let columns: [DatabaseColumnInterface] = [
            StringColumn(Model.ColumnNames.id),
            StringColumn(Model.ColumnNames.title),
            StringColumn(Model.ColumnNames.message),
            StringColumn(Model.ColumnNames.topic),
            DoubleColumn(Model.ColumnNames.date),
            DoubleColumn(Model.ColumnNames.recipients, isMandatory: false),
        ]
        public static let constraints: [DatabaseConstraintInterface] = [
            PrimaryKeyConstraint(Model.ColumnNames.id)
        ]
    }
}
