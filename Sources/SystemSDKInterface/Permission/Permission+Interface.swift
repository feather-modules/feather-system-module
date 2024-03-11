//
//  File.swift
//
//
//  Created by Tibor Bodecs on 21/02/2024.
//

import CoreSDKInterface

public protocol SystemPermissionInterface {

    func listPermissions(
        _ input: System.Permission.List.Query
    ) async throws -> System.Permission.List

    func referencePermissions(
        keys: [ID<System.Permission>]
    ) async throws -> [System.Permission.Reference]

    func createPermission(
        _ input: System.Permission.Create
    ) async throws -> System.Permission.Detail

    func getPermission(
        key: ID<System.Permission>
    ) async throws -> System.Permission.Detail

    func updatePermission(
        key: ID<System.Permission>,
        _ input: System.Permission.Update
    ) async throws -> System.Permission.Detail

    func patchPermission(
        key: ID<System.Permission>,
        _ input: System.Permission.Patch
    ) async throws -> System.Permission.Detail

    func bulkDeletePermission(
        keys: [ID<System.Permission>]
    ) async throws

}
