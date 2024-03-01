import CoreInterfaceKit
import Hummingbird
import Logging
import OpenAPIHummingbird
import OpenAPIRuntime
import SystemInterfaceKit
import SystemKit
import SystemOpenAPIRuntimeKit
import SystemServerKit

extension HBRouter {

    public func config(
        _ sdk: SystemInterface
    ) async throws {
        middlewares.add(HBLogRequestsMiddleware(.info))

        let apiGateway = SystemAPIGateway(
            sdk: sdk,
            logger: .init(label: "system-api-gateway")
        )

        try apiGateway.registerHandlers(
            on: self,
            serverURL: Servers.server1(),
            configuration: .init(
                dateTranscoder: CustomDateTranscoder()
            ),
            middlewares: [
                ServerErrorMiddleware(),
                // auth needs to be the last
                TestAuthMiddleware(),
            ]
        )
    }
}
