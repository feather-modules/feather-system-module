//
//  File.swift
//
//
//  Created by Tibor Bodecs on 04/02/2024.
//

import CoreInterfaceKit
import FeatherComponent
import FeatherValidation
import Logging
import SystemInterfaceKit

extension SystemSDK {

    public func listPermissions(
        _ input: List.Query<
            System.Permission.List.Sort
        >
    ) async throws
        -> List.Result<
            System.Permission.List.Item,
            System.Permission.List.Sort
        >
    {
        let user = try await ACL.require(ACL.AuthenticatedUser.self)
        try await user.requirePermission(
            System.Permission.ACL.list.rawValue
        )

        do {
            let db = try await components.relationalDatabase().connection()
            let queryBuilder = System.Permission.Query(db: db)

            return
                try await queryBuilder.all(
                    query: .init(
                        input: input,
                        queryBuilderType: System.Permission.Query.self
                    )
                )
                .toResult(input: input) { $0.toListItem() }
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func createPermission(
        _ input: System.Permission.Create
    ) async throws -> System.Permission.Detail {
        let user = try await ACL.require(ACL.AuthenticatedUser.self)
        try await user.requirePermission(
            System.Permission.ACL.create.rawValue
        )

        do {
            let db = try await components.relationalDatabase().connection()
            let qb = System.Permission.Query(db: db)

            // NOTE: unique key validation workaround
            try await KeyValueValidator(
                key: "key",
                value: input.key.rawValue,
                rules: [
                    .init(
                        message: "Key needs to be unique",
                        { value in
                            guard
                                try await qb.firstById(
                                    value: input.key.rawValue
                                ) == nil
                            else {
                                throw RuleError.invalid
                            }
                        }
                    )
                ]
            )
            .validate()

            // TODO: proper validation
            //            try await input.validate()
            let model = System.Permission.Model(input)
            try await qb.insert(model)

            return model.toDetail()
        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func getPermission(
        key: ID<System.Permission>
    ) async throws -> System.Permission.Detail {
        let user = try await ACL.require(ACL.AuthenticatedUser.self)
        try await user.requirePermission(
            System.Permission.ACL.get.rawValue
        )

        do {
            let db = try await components.relationalDatabase().connection()
            let qb = System.Permission.Query(db: db)
            guard let model = try await qb.firstById(value: key.rawValue) else {
                throw SystemSDKError.unknown
            }
            return model.toDetail()
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func updatePermission(
        key: ID<System.Permission>,
        _ input: System.Permission.Update
    ) async throws -> System.Permission.Detail {
        let user = try await ACL.require(ACL.AuthenticatedUser.self)
        try await user.requirePermission(
            System.Permission.ACL.update.rawValue
        )

        do {
            let db = try await components.relationalDatabase().connection()
            let qb = System.Permission.Query(db: db)

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
            throw SystemSDKError.database(error)
        }
    }

    public func patchPermission(
        key: ID<System.Permission>,
        _ input: System.Permission.Patch
    ) async throws -> System.Permission.Detail {
        let user = try await ACL.require(ACL.AuthenticatedUser.self)
        try await user.requirePermission(
            System.Permission.ACL.update.rawValue
        )

        do {
            let db = try await components.relationalDatabase().connection()
            let qb = System.Permission.Query(db: db)

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
            throw SystemSDKError.database(error)
        }
    }

    public func bulkDeletePermission(keys: [ID<System.Permission>])
        async throws
    {
        let user = try await ACL.require(ACL.AuthenticatedUser.self)
        try await user.requirePermission(
            System.Permission.ACL.delete.rawValue
        )

        do {
            let db = try await components.relationalDatabase().connection()
            let qb = System.Permission.Query(db: db)
            try await qb.delete(keys.map { $0.rawValue })
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }
    
    public func getPermissionReferences(
        keys: [ID<System.Permission>]
    ) async throws -> [System.Permission.Reference] {
        do {
            let db = try await components.relationalDatabase().connection()
            let qb = System.Permission.Query(db: db)
            return try await qb.select()
                .filter { keys.contains($0.key.toID()) }
                .map { $0.toReference() }
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }
}
