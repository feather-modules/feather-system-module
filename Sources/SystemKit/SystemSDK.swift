import Logging
import FeatherComponent
import FeatherValidation
import CoreInterfaceKit
import SystemInterfaceKit

public enum SystemSDKError: Error {
    case unknown
    case database(Error)

    case validation([Failure])
}

public struct SystemSDK: SystemInterface {

    let components: ComponentRegistry
    let logger: Logger

    public init(
        components: ComponentRegistry,
        logger: Logger = .init(label: "sdk")
    ) {
        self.components = components
        self.logger = logger
    }

}
