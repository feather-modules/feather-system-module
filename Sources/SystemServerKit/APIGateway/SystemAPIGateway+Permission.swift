//
//  File.swift
//
//
//  Created by Tibor Bodecs on 21/02/2024.
//

import FeatherComponent
import Logging
import OpenAPIRuntime
import SystemInterfaceKit
import SystemKit
import SystemOpenAPIRuntimeKit

extension SystemAPIGateway {

    public func listSystemPermission(
        _ input: Operations.listSystemPermission.Input
    )
        async throws -> Operations.listSystemPermission.Output
    {
        let result = try await sdk.listSystemPermissions(input.query.toSDK())
        return .ok(.init(body: .json(result.toAPI())))
    }

    public func createSystemPermission(
        _ input: Operations.createSystemPermission.Input
    )
        async throws -> Operations.createSystemPermission.Output
    {
        switch input.body {
        case .json(let content):
            let result = try await sdk.createSystemPermission(content.toSDK())
            return .ok(.init(body: .json(result.toAPI())))
        }
    }

    public func bulkDeleteSystemPermission(
        _ input: Operations.bulkDeleteSystemPermission.Input
    ) async throws -> Operations.bulkDeleteSystemPermission.Output {
        switch input.body {
        case .json(let content):
            try await sdk.bulkDeleteSystemPermission(keys: content.toSDK())
            return .noContent(.init())
        }
    }

    public func detailSystemPermission(
        _ input: Operations.detailSystemPermission.Input
    )
        async throws -> Operations.detailSystemPermission.Output
    {
        let result = try await sdk.getSystemPermission(
            key: .init(input.path.permissionKey)
        )
        return .ok(.init(body: .json(result.toAPI())))
    }

    public func patchSystemPermission(
        _ input: Operations.patchSystemPermission.Input
    )
        async throws -> Operations.patchSystemPermission.Output
    {
        switch input.body {
        case .json(let content):
            let result = try await sdk.patchSystemPermission(
                key: .init(input.path.permissionKey),
                content.toSDK()
            )
            return .ok(.init(body: .json(result.toAPI())))
        }
    }

    public func updateSystemPermission(
        _ input: Operations.updateSystemPermission.Input
    )
        async throws -> Operations.updateSystemPermission.Output
    {
        switch input.body {
        case .json(let content):
            let result = try await sdk.updateSystemPermission(
                key: .init(input.path.permissionKey),
                content.toSDK()
            )
            return .ok(.init(body: .json(result.toAPI())))
        }
    }
}
