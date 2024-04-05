import FeatherACL
import FeatherModuleKit

extension FeatherACL.Permission {

    static func system(_ context: String, action: Action) -> Self {
        .init(namespace: "system", context: context, action: action)
    }
}

public enum System {

    public enum ACL: ACLSet {

        public static var all: [FeatherACL.Permission] {
            Permission.ACL.all + Variable.ACL.all
        }
    }

    public enum Error: Swift.Error {
        case unknown
    }

    public enum Mobile {}
    public enum AccessToken: Identifiable {}
    public enum PushMessage: Identifiable {}
    public enum Permission: Identifiable {}
    public enum Variable: Identifiable {}
}

public protocol SystemModuleInterface: ModuleInterface {
    var permission: SystemPermissionInterface { get }
    var variable: SystemVariableInterface { get }
}
