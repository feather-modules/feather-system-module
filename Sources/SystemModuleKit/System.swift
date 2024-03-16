import CoreModuleKit

extension Permission {

    static func system(_ context: String, action: Action) -> Self {
        .init(namespace: "system", context: context, action: action)
    }
}

public enum System {

    public enum ACL: ACLSet {

        public static var all: [CoreModuleKit.Permission] {
            Permission.ACL.all + Variable.ACL.all
        }
    }

    public enum Error: Swift.Error {
        case permissionNotFound
        case variableNotFound
    }

    public enum AccessToken {}
    public enum Mobile {}
    public enum Permission: Identifiable {}
    public enum Variable: Identifiable {}
}

public protocol SystemModuleInterface: ModuleInterface {
    var permission: SystemPermissionInterface { get }
    var variable: SystemVariableInterface { get }
}
