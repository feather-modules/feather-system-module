//
//  File.swift
//
//
//  Created by Tibor Bodecs on 30/01/2024.
//

import CoreSDKInterface

public protocol SystemVariableInterface {

    func listVariables(
        _ input: any SystemVariableListQuery
    ) async throws -> any SystemVariableList

    func referenceVariables(
        keys: [ID<System.Variable>]
    ) async throws -> [SystemVariableReference]

    func createVariable(
        _ input: SystemVariableCreate
    ) async throws -> SystemVariableDetail

    func getVariable(
        key: ID<System.Variable>
    ) async throws -> SystemVariableDetail

    func updateVariable(
        key: ID<System.Variable>,
        _ input: SystemVariableUpdate
    ) async throws -> SystemVariableDetail

    func patchVariable(
        key: ID<System.Variable>,
        _ input: SystemVariablePatch
    ) async throws -> SystemVariableDetail

    func bulkDeleteVariable(
        keys: [ID<System.Variable>]
    ) async throws

}
