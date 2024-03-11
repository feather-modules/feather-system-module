//
//  File.swift
//
//
//  Created by Tibor Bodecs on 30/01/2024.
//

import CoreSDKInterface

public protocol SystemVariableInterface {

    func listVariables(
        _ input: System.Variable.List.Query
    ) async throws -> System.Variable.List

    func referenceVariables(
        keys: [ID<System.Variable>]
    ) async throws -> [System.Variable.Reference]

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

    func bulkDeleteVariable(
        keys: [ID<System.Variable>]
    ) async throws

}
