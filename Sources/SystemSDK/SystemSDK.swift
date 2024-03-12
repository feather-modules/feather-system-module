import CoreSDKInterface
import FeatherComponent
import FeatherValidation
import Logging
import SystemSDKInterface

public struct SystemSDK: SystemInterface {

    let components: ComponentRegistry
    let logger: Logger

    public init(
        components: ComponentRegistry,
        logger: Logger = .init(label: "system-sdk")
    ) {
        self.components = components
        self.logger = logger
    }

    public var permission: SystemPermissionInterface {
        SystemPermissionSDK(
            components: components,
            logger: logger
        )
    }

    public var variable: SystemVariableInterface {
        SystemVariableRepository(
            components: components,
            logger: logger
        )
    }
}
