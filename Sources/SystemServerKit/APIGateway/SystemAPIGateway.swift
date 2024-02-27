import FeatherComponent
import Foundation
import Logging
import OpenAPIRuntime
import SystemInterfaceKit
import SystemKit
import SystemOpenAPIRuntimeKit

public struct SystemAPIGateway: APIProtocol {

    let sdk: SystemInterface
    let logger: Logger

    public init(
        sdk: SystemInterface,
        logger: Logger = .init(label: "api-gateway")
    ) {
        self.sdk = sdk
        self.logger = logger
    }

}
