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
            let queryBuilder = try await getQueryBuilder()

            var field: System.Variable.Model.FieldKeys
            switch input.sort.by {
            case .key:
                field = .key
            case .name:
                field = .name
            case .value:
                field = .value
            }

            let search = input.search.flatMap { value in
                QueryFilter<System.Variable.Model.CodingKeys>(
                    field: .key,
                    method: .like,
                    value: "%\(value)%"
                )
            }

            let result = try await queryBuilder.list(
                .init(
                    page: .init(
                        size: input.page.size,
                        index: input.page
                            .index
                    ),
                    sort: .init(
                        field: field,
                        direction: input.sort.order.queryDirection
                    ),
                    search: search
                )
            )

            return try System.Variable.List(
                items: result.items.map {
                    try $0.convert(to: System.Variable.List.Item.self)
                },
                query: .init(
                    search: input.search,
                    sort: .init(by: input.sort.by, order: input.sort.order),
                    page: .init(size: input.page.size, index: input.page.index)
                ),
                page: .init(size: input.page.size, index: input.page.index),
                count: UInt(result.total)
            )
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func referenceVariables(
        keys: [ID<System.Variable>]
    ) async throws -> [SystemVariableReference] {
        do {
            let queryBuilder = try await getQueryBuilder()

            return try await queryBuilder.all(.key, .in, keys)
                .convert(to: [System.Variable.Reference].self)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func createVariable(
        _ input: SystemVariableCreate
    ) async throws -> SystemVariableDetail {
        do {
            let queryBuilder = try await getQueryBuilder()

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

            let model = try input.convert(to: System.Variable.Model.self)
            try await queryBuilder.insert(model)
            return try model.convert(to: System.Variable.Detail.self)
        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func getVariable(
        key: ID<System.Variable>
    ) async throws -> SystemVariableDetail {
        do {
            let queryBuilder = try await getQueryBuilder()
            guard let model = try await queryBuilder.get(key) else {
                throw SystemSDKError.unknown
            }
            return try model.convert(to: System.Variable.Detail.self)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func updateVariable(
        key: ID<System.Variable>,
        _ input: SystemVariableUpdate
    ) async throws -> SystemVariableDetail {
        do {
            let queryBuilder = try await getQueryBuilder()

            guard try await queryBuilder.get(key) != nil else {
                throw SystemSDKError.unknown
            }
            //TODO: validate input
            let newModel = System.Variable.Model(
                key: input.key.toKey(),
                value: input.value,
                name: input.name,
                notes: input.notes
            )
            try await queryBuilder.update(key, newModel)
            return try newModel.convert(to: System.Variable.Detail.self)

        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func patchVariable(
        key: ID<System.Variable>,
        _ input: SystemVariablePatch
    ) async throws -> SystemVariableDetail {
        do {
            let queryBuilder = try await getQueryBuilder()

            guard let oldModel = try await queryBuilder.get(key) else {
                throw SystemSDKError.unknown
            }
            //TODO: validate input
            let newModel = System.Variable.Model(
                key: input.key?.toKey() ?? oldModel.key,
                value: input.value ?? oldModel.value,
                name: input.name ?? oldModel.name,
                notes: input.notes ?? oldModel.notes
            )
            try await queryBuilder.update(key, newModel)
            return try newModel.convert(to: System.Variable.Detail.self)

        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func bulkDeleteVariable(
        keys: [ID<System.Variable>]
    ) async throws {
        do {
            let queryBuilder = try await getQueryBuilder()
            try await queryBuilder.delete(keys)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }
}
