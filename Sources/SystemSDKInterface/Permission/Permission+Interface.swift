//
//  File.swift
//
//
//  Created by Tibor Bodecs on 21/02/2024.
//

import CoreSDKInterface

public protocol SystemPermissionInterface {

    func listPermissions(
        _ input: any SystemPermissionListQuery
    ) async throws -> any SystemPermissionList

    func referencePermissions(
        keys: [ID<System.Permission>]
    ) async throws -> [SystemPermissionReference]

    func createPermission(
        _ input: SystemPermissionCreate
    ) async throws -> SystemPermissionDetail

    func getPermission(
        key: ID<System.Permission>
    ) async throws -> SystemPermissionDetail

    func updatePermission(
        key: ID<System.Permission>,
        _ input: SystemPermissionUpdate
    ) async throws -> SystemPermissionDetail

    func patchPermission(
        key: ID<System.Permission>,
        _ input: SystemPermissionPatch
    ) async throws -> SystemPermissionDetail

    func bulkDeletePermission(
        keys: [ID<System.Permission>]
    ) async throws

}
