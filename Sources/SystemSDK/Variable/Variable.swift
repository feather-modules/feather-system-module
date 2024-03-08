//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/01/2024.
//

import CoreSDK
import CoreSDKInterface
import DatabaseQueryKit
import FeatherComponent
import FeatherValidation
import Logging
import SystemSDKInterface

extension SystemSDK {

    private func getQueryBuilder() async throws -> System.Variable.Query {
        let rdb = try await components.relationalDatabase()
        let db = try await rdb.database()
        return System.Variable.Query(db: db)
    }
}

extension SystemSDK {

    public func listVariables(
        _ input: any SystemVariableListQuery
    ) async throws -> any SystemVariableList {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let queryBuilder = System.Variable.Query(db: db)

            fatalError()
            //            // TODO: fix sort & order
            //            let result = try await queryBuilder.all(
            //                query: .init(
            //                    page: .init(
            //                        size: Int(input.page.size),
            //                        index: Int(input.page.index)
            //                    ),
            //                    filter: .init(relation: .and, conditions: []),
            //                    sort: []
            //                )
            //            )
            //
            //            return try System.Variable.List(
            //                items: result.data.map {
            //                    try $0.convert(to: System.Variable.List.Item.self)
            //                },
            //                query: .init(
            //                    search: input.search,
            //                    sort: .init(by: input.sort.by, order: input.sort.order),
            //                    page: .init(size: input.page.size, index: input.page.index)
            //                ),
            //                page: .init(size: input.page.size, index: input.page.index),
            //                count: UInt(result.count)
            //            )
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func referenceVariables(
        keys: [CoreSDKInterface.ID<System.Variable>]
    ) async throws -> [SystemVariableReference] {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let qb = System.Variable.Query(db: db)

            fatalError()
            //            return try await qb.select()
            //                .filter { keys.contains($0.key.toID()) }
            //                .map { try $0.convert(to: System.Variable.Reference.self) }
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func createVariable(
        _ input: SystemVariableCreate
    ) async throws -> SystemVariableDetail {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let qb = System.Variable.Query(db: db)

            fatalError()
            //            // NOTE: unique key validation workaround
            //            try await KeyValueValidator(
            //                key: "key",
            //                value: input.key.rawValue,
            //                rules: [
            //                    .init(
            //                        message: "Key needs to be unique",
            //                        { value in
            //                            guard
            //                                try await qb.firstById(
            //                                    value: input.key.rawValue
            //                                ) == nil
            //                            else {
            //                                throw RuleError.invalid
            //                            }
            //                        }
            //                    )
            //                ]
            //            )
            //            .validate()
            //
            //            // TODO: proper validation
            //            //            try await input.validate()
            //
            //            let model = try input.convert(to: System.Variable.Model.self)
            //            try await qb.insert(model)
            //            return try model.convert(to: System.Variable.Detail.self)
        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func getVariable(
        key: CoreSDKInterface.ID<System.Variable>
    ) async throws -> SystemVariableDetail {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let qb = System.Variable.Query(db: db)
            fatalError()
            //            guard let model = try await qb.firstById(value: key.rawValue) else {
            //                throw SystemSDKError.unknown
            //            }
            //            return try model.convert(to: System.Variable.Detail.self)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func updateVariable(
        key: CoreSDKInterface.ID<System.Variable>,
        _ input: SystemVariableUpdate
    ) async throws -> SystemVariableDetail {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let qb = System.Variable.Query(db: db)

            fatalError()
            //            guard let model = try await qb.firstById(value: key.rawValue) else {
            //                throw SystemSDKError.unknown
            //            }
            //            //TODO: validate input
            //            let newModel = System.Variable.Model(
            //                key: input.key.toKey(),
            //                value: input.value,
            //                name: input.name,
            //                notes: input.notes ?? model.notes
            //            )
            //            try await qb.update(key.rawValue, newModel)
            //            return try model.convert(to: System.Variable.Detail.self)
        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func patchVariable(
        key: CoreSDKInterface.ID<System.Variable>,
        _ input: SystemVariablePatch
    ) async throws -> SystemVariableDetail {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let qb = System.Variable.Query(db: db)

            fatalError()
            //            guard let model = try await qb.firstById(value: key.rawValue) else {
            //                throw SystemSDKError.unknown
            //            }
            //            //TODO: validate input
            //            let newModel = System.Variable.Model(
            //                key: input.key?.toKey() ?? model.key,
            //                value: input.value ?? model.value,
            //                name: input.name ?? model.name,
            //                notes: input.notes ?? model.notes
            //            )
            //            try await qb.update(key.rawValue, newModel)
            //            return try model.convert(to: System.Variable.Detail.self)
        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func bulkDeleteVariable(
        keys: [CoreSDKInterface.ID<System.Variable>]
    ) async throws {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let qb = System.Variable.Query(db: db)
            //            try await qb.delete(keys.map { $0.rawValue })
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }
}
