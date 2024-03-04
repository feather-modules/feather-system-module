//
//  File.swift
//
//
//  Created by Tibor Bodecs on 21/02/2024.
//

import CoreInterfaceKit

public protocol SystemPermissionInterface {

    func listPermissions(
        _ input: List.Query<
            System.Permission.List.Sort
        >
    ) async throws
        -> List.Result<
            System.Permission.List.Item,
            System.Permission.List.Sort
        >

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
    
    // MARK: -
    
    func getPermissionReferences(
        keys: [ID<System.Permission>]
    ) async throws -> [System.Permission.Reference]
    
}
