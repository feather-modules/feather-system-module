import CoreSDKInterface

public enum System {

    public enum Error: Swift.Error {
        case permissionNotFound
        case variableNotFound
    }

    public enum AccessToken {}
    public enum Mobile {}
    public enum Permission: Identifiable {}
    public enum Variable: Identifiable {}
}

public protocol SystemInterface: CoreInterface {
    var permission: SystemPermissionInterface { get }
    var variable: SystemVariableInterface { get }
}
