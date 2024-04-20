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
        ids: [ID<System.Variable>]
    ) async throws -> [System.Variable.Reference]

    func create(
        _ input: System.Variable.Create
    ) async throws -> System.Variable.Detail

    func get(
        _ id: ID<System.Variable>
    ) async throws -> System.Variable.Detail

    func update(
        _ id: ID<System.Variable>,
        _ input: System.Variable.Update
    ) async throws -> System.Variable.Detail

    func patch(
        _ id: ID<System.Variable>,
        _ input: System.Variable.Patch
    ) async throws -> System.Variable.Detail

    func bulkDelete(
        ids: [ID<System.Variable>]
    ) async throws

}
