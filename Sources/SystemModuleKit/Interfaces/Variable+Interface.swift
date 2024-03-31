//
//  File.swift
//
//
//  Created by Tibor Bodecs on 30/01/2024.
//

import FeatherModuleKit

public protocol SystemVariableInterface: Sendable {

    func list(
        _ input: System.Variable.List.Query
    ) async throws -> System.Variable.List

    func reference(
        keys: [ID<System.Variable>]
    ) async throws -> [System.Variable.Reference]

    func create(
        _ input: System.Variable.Create
    ) async throws -> System.Variable.Detail

    func get(
        key: ID<System.Variable>
    ) async throws -> System.Variable.Detail

    func update(
        key: ID<System.Variable>,
        _ input: System.Variable.Update
    ) async throws -> System.Variable.Detail

    func patch(
        key: ID<System.Variable>,
        _ input: System.Variable.Patch
    ) async throws -> System.Variable.Detail

    func bulkDelete(
        keys: [ID<System.Variable>]
    ) async throws

}
