import FeatherComponent
import FeatherModuleKit
import FeatherValidation
import Logging
import SystemModuleKit

public struct SystemModule: SystemModuleInterface {

    let components: ComponentRegistry
    let logger: Logger

    public init(
        components: ComponentRegistry,
        logger: Logger = .init(label: "system-module")
    ) {
        self.components = components
        self.logger = logger
    }

    public var permission: SystemPermissionInterface {
        PermissionController(
            components: components,
            system: self
        )
    }

    public var variable: SystemVariableInterface {
        VariableController(
            components: components,
            system: self
        )
    }
}
