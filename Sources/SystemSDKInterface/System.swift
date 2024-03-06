import CoreSDKInterface

public enum System {

    public enum AccessToken {}
    public enum Mobile {}
    public enum Permission {}
    public enum Variable {}
}

public protocol SystemInterface:
    CoreInterface,
    SystemPermissionInterface,
    SystemVariableInterface
{

}
