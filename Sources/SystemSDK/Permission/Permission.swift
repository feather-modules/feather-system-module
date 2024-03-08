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

    private func getQueryBuilder() async throws -> System.Permission.Query {
        let rdb = try await components.relationalDatabase()
        let db = try await rdb.database()
        return System.Permission.Query(db: db)
    }
}

extension Order {
    var queryDirection: QueryDirection {
        switch self {
        case .asc: .asc
        case .desc: .desc
        }
    }
}

extension SystemSDK {

    public func listPermissions(
        _ input: any SystemPermissionListQuery
    ) async throws -> any SystemPermissionList {
        do {
            let queryBuilder = try await getQueryBuilder()

            var field: System.Permission.Model.FieldKeys
            switch input.sort.by {
            case .key:
                field = .key
            case .name:
                field = .name
            }

            let search = input.search.flatMap { value in
                QueryFilter<System.Permission.Model.CodingKeys>(
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

            return try System.Permission.List(
                items: result.items.map {
                    try $0.convert(to: System.Permission.List.Item.self)
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

    public func referencePermissions(
        keys: [ID<System.Permission>]
    ) async throws -> [SystemPermissionReference] {
        do {
            let queryBuilder = try await getQueryBuilder()

            return try await queryBuilder.all(.key, .in, keys)
                .convert(to: [System.Permission.Reference].self)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func createPermission(
        _ input: SystemPermissionCreate
    ) async throws -> SystemPermissionDetail {
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
            let model = try input.convert(to: System.Permission.Model.self)
            try await queryBuilder.insert(model)
            return try model.convert(to: System.Permission.Detail.self)
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
    ) async throws -> SystemPermissionDetail {
        do {
            let queryBuilder = try await getQueryBuilder()

            guard let model = try await queryBuilder.get(key) else {
                throw SystemSDKError.unknown
            }
            return try model.convert(to: System.Permission.Detail.self)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func updatePermission(
        key: ID<System.Permission>,
        _ input: SystemPermissionUpdate
    ) async throws -> SystemPermissionDetail {
        do {
            let queryBuilder = try await getQueryBuilder()

            guard try await queryBuilder.get(key) != nil else {
                throw SystemSDKError.unknown
            }
            //TODO: validate input
            let newModel = System.Permission.Model(
                key: input.key.toKey(),
                name: input.name,
                notes: input.notes
            )
            try await queryBuilder.update(key, newModel)
            return try newModel.convert(to: System.Permission.Detail.self)
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
        _ input: SystemPermissionPatch
    ) async throws -> SystemPermissionDetail {
        do {
            let queryBuilder = try await getQueryBuilder()

            guard let oldModel = try await queryBuilder.get(key) else {
                throw SystemSDKError.unknown
            }
            //TODO: validate input
            let newModel = System.Permission.Model(
                key: input.key?.toKey() ?? oldModel.key,
                name: input.name ?? oldModel.name,
                notes: input.notes ?? oldModel.notes
            )
            try await queryBuilder.update(key, newModel)
            return try newModel.convert(to: System.Permission.Detail.self)
        }
        catch let error as ValidatorError {
            throw SystemSDKError.validation(error.failures)
        }
        catch {
            throw SystemSDKError.database(error)
        }
    }

    public func bulkDeletePermission(
        keys: [ID<System.Permission>]
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
