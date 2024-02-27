//
//  File.swift
//
//
//  Created by Tibor Bodecs on 16/02/2024.
//

import FeatherComponent
import FeatherOpenAPISpec
import FeatherOpenAPISpecHummingbird
import Hummingbird
import HummingbirdXCT
import SystemKit
import SystemMigrationKit
import SystemOpenAPIRuntimeKit
import SystemServerKit
import XCTest

class TestCase: XCTestCase {

    var components: ComponentRegistry!
    var sdk: SystemSDK!
    var server: (any HBApplicationProtocol)!
    var runner: SpecRunner!

    override func setUp() async throws {

        let router = HBRouter()

        components = ComponentRegistry()
        sdk = SystemSDK(components: components, logger: .init(label: "sdk"))
        try await router.config(sdk)

        server = HBApplication(
            responder: router.buildResponder(),
            configuration: .init(
                serverName: "SystemTestServer"
            )
        )
        runner = HummingbirdExpectationRequestRunner(app: server)

        try await components.configure(.singleton, server.eventLoopGroup)
        try await components.run()
        try await components.runMigrations()
    }

    override func tearDown() async throws {
        try await components.shutdown()
    }

    func runSpec(
        @SpecBuilder builder: () -> SpecBuilderParameter
    ) async throws {
        try await SpecBuilder {
            builder()
        }
        .build(using: runner)
        .test()
    }

    func getAuthToken() async throws -> String {
        ""
        //        let auth = try await sdk.postUserAuth(
        //            .init(
        //                email: "info@user.com",
        //                password: "ChangeMe1"
        //            )
        //        )
        //        return auth.token.value.rawValue
    }
}
