import CoreSDKInterface
import FeatherComponent
import FeatherValidation
import Logging
import SystemSDKInterface

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
        logger: Logger = .init(label: "system-sdk")
    ) {
        self.components = components
        self.logger = logger
    }

}
