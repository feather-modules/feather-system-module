//
//  File.swift
//
//
//  Created by Tibor Bodecs on 30/01/2024.
//

import FeatherKit

public protocol SystemVariableInterface {

    func listSystemVariables(
        _ input: List.Query<
            System.Variable.List.Sort
        >
    ) async throws
        -> List.Result<
            System.Variable.List.Item,
            System.Variable.List.Sort
        >

    func bulkDeleteSystemVariable(
        keys: [ID<System.Variable>]
    ) async throws

    func createSystemVariable(
        _ input: System.Variable.Create
    ) async throws -> System.Variable.Detail

    func getSystemVariable(
        key: ID<System.Variable>
    ) async throws -> System.Variable.Detail

    func updateSystemVariable(
        key: ID<System.Variable>,
        _ input: System.Variable.Update
    ) async throws -> System.Variable.Detail

    func patchSystemVariable(
        key: ID<System.Variable>,
        _ input: System.Variable.Patch
    ) async throws -> System.Variable.Detail

    func deleteSystemVariable(
        key: ID<System.Variable>
    ) async throws
}
