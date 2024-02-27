//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/01/2024.
//

import DatabaseQueryKit
import FeatherComponent
import FeatherKit
import FeatherValidation
import Logging
import SQLKit
import SystemInterfaceKit

extension SystemSDK {

    public func listVariables(
        _ input: List.Query<
            System.Variable.List.Sort
        >
    ) async throws
        -> List.Result<
            System.Variable.List.Item,
            System.Variable.List.Sort
        >
    {
        do {
            let db = try await components.relationalDatabase().connection()
            let queryBuilder = System.Variable.Query(db: db)

            return
                try await queryBuilder.all(
                    query: .init(
                        input: input,
                        queryBuilderType: System.Variable.Query.self
                    )
                )
                .toResult(input: input) { $0.toListItem() }
        }
        catch {
            throw SystemSDKError.unknown
        }
    }

    public func createVariable(
        _ input: System.Variable.Create
    ) async throws -> System.Variable.Detail {
        do {
            let db = try await components.relationalDatabase().connection()
            let qb = System.Variable.Query(db: db)
            // TODO: proper validation
            try await input.validate()
            let model = System.Variable.Model(input)
            try await qb.insert(model)

            return model.toDetail()
        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.unknown
        }
    }

    public func getVariable(
        key: ID<System.Variable>
    ) async throws -> System.Variable.Detail {
        do {
            let db = try await components.relationalDatabase().connection()
            let qb = System.Variable.Query(db: db)
            guard let model = try await qb.firstById(value: key.rawValue) else {
                throw SystemSDKError.unknown
            }
            return model.toDetail()
        }
        catch {
            throw SystemSDKError.unknown
        }
    }

    public func updateVariable(
        key: ID<System.Variable>,
        _ input: System.Variable.Update
    ) async throws -> System.Variable.Detail {
        do {
            let db = try await components.relationalDatabase().connection()
            let qb = System.Variable.Query(db: db)

            guard let model = try await qb.firstById(value: key.rawValue) else {
                throw SystemSDKError.unknown
            }
            //TODO: validate input
            let newModel = model.updated(input)
            try await qb.update(key.rawValue, newModel)
            return newModel.toDetail()
        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.unknown
        }
    }

    public func patchVariable(
        key: ID<System.Variable>,
        _ input: System.Variable.Patch
    ) async throws -> System.Variable.Detail {
        do {
            let db = try await components.relationalDatabase().connection()
            let qb = System.Variable.Query(db: db)

            guard let model = try await qb.firstById(value: key.rawValue) else {
                throw SystemSDKError.unknown
            }
            //TODO: validate input
            let newModel = model.patched(input)
            try await qb.update(key.rawValue, newModel)
            return newModel.toDetail()
        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.unknown
        }
    }

    public func deleteVariable(
        key: ID<System.Variable>
    ) async throws {
        try await bulkDeleteVariable(keys: [key])
    }

    public func bulkDeleteVariable(keys: [ID<System.Variable>])
        async throws
    {
        do {
            let db = try await components.relationalDatabase().connection()
            let qb = System.Variable.Query(db: db)
            try await qb.delete(keys.map { $0.rawValue })
        }
        catch {
            throw SystemSDKError.unknown
        }
    }

}
