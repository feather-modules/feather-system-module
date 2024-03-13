//
//  File.swift
//
//
//  Created by Tibor Bodecs on 16/02/2024.
//

import CoreModuleInterface
import FeatherComponent
import NIO
import SystemModule
import SystemModuleInterface
import XCTest

class TestCase: XCTestCase {

    var eventLoopGroup: EventLoopGroup!
    var components: ComponentRegistry!
    var sdk: SystemModuleInterface!

    override func setUp() async throws {
        self.eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        components = ComponentRegistry()

        sdk = SystemModule(components: components)

        try await components.configure(.singleton, eventLoopGroup)
        try await components.run()
        try await components.runMigrations()
    }

    override func tearDown() async throws {
        try await components.shutdown()
        try await self.eventLoopGroup.shutdownGracefully()
    }
}
