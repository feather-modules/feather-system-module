//
//  File.swift
//
//
//  Created by Tibor Bodecs on 21/02/2024.
//

import FeatherKit

public protocol SystemPermissionInterface {

    func listSystemPermissions(
        _ input: List.Query<
            System.Permission.List.Sort
        >
    ) async throws
        -> List.Result<
            System.Permission.List.Item,
            System.Permission.List.Sort
        >

    func createSystemPermission(
        _ input: System.Permission.Create
    ) async throws -> System.Permission.Detail

    func getSystemPermission(
        key: ID<System.Permission>
    ) async throws -> System.Permission.Detail

    func updateSystemPermission(
        key: ID<System.Permission>,
        _ input: System.Permission.Update
    ) async throws -> System.Permission.Detail

    func patchSystemPermission(
        key: ID<System.Permission>,
        _ input: System.Permission.Patch
    ) async throws -> System.Permission.Detail

    func bulkDeleteSystemPermission(
        keys: [ID<System.Permission>]
    ) async throws
}
