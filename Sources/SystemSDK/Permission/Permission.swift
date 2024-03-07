//
//  File.swift
//
//
//  Created by Tibor Bodecs on 04/02/2024.
//

import CoreSDK
import CoreSDKInterface
import DatabaseQueryKit
import FeatherComponent
import FeatherValidation
import Logging
import SystemSDKInterface


extension SystemSDK {

    public func listPermissions(
        _ input: any SystemPermissionListQuery
    ) async throws -> any SystemPermissionList {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let queryBuilder = System.Permission.Query(db: db)

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
//            return try System.Permission.List(
//                items: result.data.map {
//                    try $0.convert(to: System.Permission.List.Item.self)
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

    public func referencePermissions(
        keys: [CoreSDKInterface.ID<System.Permission>]
    ) async throws -> [SystemPermissionReference] {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let qb = System.Permission.Query(db: db)

            fatalError()
//            return try await qb.select()
//                .filter { keys.contains($0.key.toID()) }
//                .map { try $0.convert(to: System.Permission.Reference.self) }
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func createPermission(
        _ input: SystemPermissionCreate
    ) async throws -> SystemPermissionDetail {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let qb = System.Permission.Query(db: db)

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
//            let model = try input.convert(to: System.Permission.Model.self)
//            try await qb.insert(model)
//            return try model.convert(to: System.Permission.Detail.self)
        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func getPermission(
        key: CoreSDKInterface.ID<System.Permission>
    ) async throws -> SystemPermissionDetail {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let qb = System.Permission.Query(db: db)
            
            fatalError()
//            guard let model = try await qb.firstById(value: key.rawValue) else {
//                throw SystemSDKError.unknown
//            }
//            return try model.convert(to: System.Permission.Detail.self)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func updatePermission(
        key: CoreSDKInterface.ID<System.Permission>,
        _ input: SystemPermissionUpdate
    ) async throws -> SystemPermissionDetail {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let qb = System.Permission.Query(db: db)

            fatalError()
//            guard let model = try await qb.firstById(value: key.rawValue) else {
//                throw SystemSDKError.unknown
//            }
//            //TODO: validate input
//            let newModel = System.Permission.Model(
//                key: input.key.toKey(),
//                name: input.name,
//                notes: input.notes ?? model.notes
//            )
//            try await qb.update(key.rawValue, newModel)
//            return try model.convert(to: System.Permission.Detail.self)
        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func patchPermission(
        key: CoreSDKInterface.ID<System.Permission>,
        _ input: SystemPermissionPatch
    ) async throws -> SystemPermissionDetail {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let qb = System.Permission.Query(db: db)

            fatalError()
//            guard let model = try await qb.firstById(value: key.rawValue) else {
//                throw SystemSDKError.unknown
//            }
//            //TODO: validate input
//            let newModel = System.Permission.Model(
//                key: input.key?.toKey() ?? model.key,
//                name: input.name ?? model.name,
//                notes: input.notes ?? model.notes
//            )
//            try await qb.update(key.rawValue, newModel)
//            return try model.convert(to: System.Permission.Detail.self)
        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func bulkDeletePermission(
        keys: [CoreSDKInterface.ID<System.Permission>]
    ) async throws {
        do {
            let rdb = try await components.relationalDatabase()
            let db = try await rdb.database()
            let qb = System.Permission.Query(db: db)
            try await qb.delete(keys.map { $0.rawValue })
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }
}
