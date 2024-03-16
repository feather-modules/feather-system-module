import DatabaseMigrationKit
import MigrationKit

public struct SystemMigrationGroup: MigrationGroup {

    public init() {}

    public func migrations() -> [Migration] {
        [
            Version1.AccessToken(),
            Version1.Permission(),
            Version1.PushMessage(),
            Version1.Variable(),
        ]
    }
}

extension SystemMigrationGroup {
    enum Version1 {}
}
