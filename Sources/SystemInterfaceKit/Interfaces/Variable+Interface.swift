//
//  File.swift
//
//
//  Created by Tibor Bodecs on 30/01/2024.
//

import FeatherKit

public protocol SystemVariableInterface {

    func listVariables(
        _ input: List.Query<
            System.Variable.List.Sort
        >
    ) async throws
        -> List.Result<
            System.Variable.List.Item,
            System.Variable.List.Sort
        >

    func bulkDeleteVariable(
        keys: [ID<System.Variable>]
    ) async throws

    func createVariable(
        _ input: System.Variable.Create
    ) async throws -> System.Variable.Detail

    func getVariable(
        key: ID<System.Variable>
    ) async throws -> System.Variable.Detail

    func updateVariable(
        key: ID<System.Variable>,
        _ input: System.Variable.Update
    ) async throws -> System.Variable.Detail

    func patchVariable(
        key: ID<System.Variable>,
        _ input: System.Variable.Patch
    ) async throws -> System.Variable.Detail

    func deleteVariable(
        key: ID<System.Variable>
    ) async throws
}
