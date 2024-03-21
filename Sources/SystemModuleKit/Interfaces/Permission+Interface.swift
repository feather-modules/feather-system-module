//
//  File.swift
//
//
//  Created by Tibor Bodecs on 21/02/2024.
//

import CoreModuleKit

public protocol SystemPermissionInterface: Sendable {

    func list(
        _ input: System.Permission.List.Query
    ) async throws -> System.Permission.List

    func reference(
        keys: [ID<System.Permission>]
    ) async throws -> [System.Permission.Reference]

    func create(
        _ input: System.Permission.Create
    ) async throws -> System.Permission.Detail

    func get(
        key: ID<System.Permission>
    ) async throws -> System.Permission.Detail

    func update(
        key: ID<System.Permission>,
        _ input: System.Permission.Update
    ) async throws -> System.Permission.Detail

    func patch(
        key: ID<System.Permission>,
        _ input: System.Permission.Patch
    ) async throws -> System.Permission.Detail

    func bulkDelete(
        keys: [ID<System.Permission>]
    ) async throws

}
