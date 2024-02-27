//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/01/2024.
//

import FeatherComponent
import Logging
import OpenAPIRuntime
import SystemInterfaceKit
import SystemKit
import SystemOpenAPIRuntimeKit

extension SystemAPIGateway {

    public func listSystemVariable(
        _ input: Operations.listSystemVariable.Input
    ) async throws -> Operations.listSystemVariable.Output {
        let result = try await sdk.listSystemVariables(input.query.toSDK())
        return .ok(.init(body: .json(result.toAPI())))
    }

    public func createSystemVariable(
        _ input: Operations.createSystemVariable.Input
    ) async throws -> Operations.createSystemVariable.Output {
        switch input.body {
        case .json(let content):
            let result = try await sdk.createSystemVariable(content.toSDK())
            return .ok(.init(body: .json(result.toAPI())))
        }
    }

    public func bulkDeleteSystemVariable(
        _ input: Operations.bulkDeleteSystemVariable.Input
    ) async throws -> Operations.bulkDeleteSystemVariable.Output {
        switch input.body {
        case .json(let content):
            try await sdk.bulkDeleteSystemVariable(keys: content.toSDK())
            return .noContent(.init())
        }
    }

    public func getSystemVariable(_ input: Operations.getSystemVariable.Input)
        async throws -> Operations.getSystemVariable.Output
    {
        let result = try await sdk.getSystemVariable(key: .init(input.path.key))
        return .ok(.init(body: .json(result.toAPI())))
    }

    public func patchSystemVariable(
        _ input: Operations.patchSystemVariable.Input
    ) async throws -> Operations.patchSystemVariable.Output {
        switch input.body {
        case .json(let content):
            let result = try await sdk.patchSystemVariable(
                key: .init(input.path.key),
                content.toSDK()
            )
            return .ok(.init(body: .json(result.toAPI())))
        }
    }

    public func updateSystemVariable(
        _ input: Operations.updateSystemVariable.Input
    ) async throws -> Operations.updateSystemVariable.Output {
        switch input.body {
        case .json(let content):
            let result = try await sdk.updateSystemVariable(
                key: .init(input.path.key),
                content.toSDK()
            )
            return .ok(.init(body: .json(result.toAPI())))
        }
    }
}
