import FeatherDatabase
import SystemModuleDatabaseKit
import SystemModuleKit

extension System.AccessToken {

    public enum Table: DatabaseTable {
        public static let tableName = Model.tableName
        public static let columns: [DatabaseColumnInterface] = [
            StringColumn(Model.ColumnNames.token)
        ]
        public static let constraints: [DatabaseConstraintInterface] = [
            PrimaryKeyConstraint(Model.ColumnNames.token)
        ]
    }
}
