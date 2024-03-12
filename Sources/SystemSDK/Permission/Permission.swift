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

extension SystemPermissionSDK {

    private func getQueryBuilder() async throws -> System.Permission.Query {
        let rdb = try await components.relationalDatabase()
        let db = try await rdb.database()
        return System.Permission.Query(db: db)
    }
}

struct SystemPermissionSDK: SystemPermissionInterface {
    let components: ComponentRegistry
    let logger: Logger

    public init(
        components: ComponentRegistry,
        logger: Logger = .init(label: "system-permission-sdk")
    ) {
        self.components = components
        self.logger = logger
    }

    public func list(
        _ input: System.Permission.List.Query
    ) async throws -> System.Permission.List {

        let queryBuilder = try await getQueryBuilder()

        var field: System.Permission.Model.FieldKeys
        switch input.sort.by {
        case .key:
            field = .key
        case .name:
            field = .name
        }

        let filterGroup = input.search.flatMap { value in
            QueryFilterGroup<System.Permission.Model.CodingKeys>(
                relation: .or,
                filters: [
                    .init(
                        field: .key,
                        operator: .like,
                        value: "%\(value)%"
                    ),
                    .init(
                        field: .name,
                        operator: .like,
                        value: "%\(value)%"
                    ),
                    .init(
                        field: .notes,
                        operator: .like,
                        value: "%\(value)%"
                    ),
                ]
            )
        }

        let result = try await queryBuilder.list(
            .init(
                page: .init(
                    size: input.page.size,
                    index: input.page.index
                ),
                orders: [
                    .init(
                        field: field,
                        direction: input.sort.order.queryDirection
                    )
                ],
                filterGroup: filterGroup
            )
        )

        return try System.Permission.List(
            items: result.items.map {
                try $0.convert(to: System.Permission.List.Item.self)
            },
            count: UInt(result.total)
        )
    }

    public func reference(
        keys: [ID<System.Permission>]
    ) async throws -> [System.Permission.Reference] {
        let queryBuilder = try await getQueryBuilder()

        return
            try await queryBuilder.all(
                filter: .init(
                    field: .key,
                    operator: .in,
                    value: keys
                )
            )
            .convert(to: [System.Permission.Reference].self)
    }

    public func create(
        _ input: System.Permission.Create
    ) async throws -> System.Permission.Detail {

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

    public func get(
        key: ID<System.Permission>
    ) async throws -> System.Permission.Detail {
        let queryBuilder = try await getQueryBuilder()

        guard let model = try await queryBuilder.get(key) else {
            throw System.Error.permissionNotFound
        }
        return try model.convert(to: System.Permission.Detail.self)
    }

    public func update(
        key: ID<System.Permission>,
        _ input: System.Permission.Update
    ) async throws -> System.Permission.Detail {
        let queryBuilder = try await getQueryBuilder()

        guard try await queryBuilder.get(key) != nil else {
            throw System.Error.permissionNotFound
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

    public func patch(
        key: ID<System.Permission>,
        _ input: System.Permission.Patch
    ) async throws -> System.Permission.Detail {
        let queryBuilder = try await getQueryBuilder()

        guard let oldModel = try await queryBuilder.get(key) else {
            throw System.Error.permissionNotFound
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

    public func bulkDelete(
        keys: [ID<System.Permission>]
    ) async throws {

        let queryBuilder = try await getQueryBuilder()
        try await queryBuilder.delete(
            filter: .init(
                field: .key,
                operator: .in,
                value: keys
            )
        )
    }
}
