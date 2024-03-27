//
//  File.swift
//
//
//  Created by Tibor Bodecs on 04/02/2024.
//

import CoreModule
import CoreModuleKit
import DatabaseQueryKit
import FeatherComponent
import FeatherValidation
import Logging
import SystemModuleDatabaseKit
import SystemModuleKit

struct PermissionRepository: SystemPermissionInterface {

    let components: ComponentRegistry
    let system: SystemModuleInterface

    public init(
        components: ComponentRegistry,
        system: SystemModuleInterface
    ) {
        self.components = components
        self.system = system
    }

    // MARK: -

    private func getQueryBuilder() async throws -> System.Permission.Query {
        let rdb = try await components.relationalDatabase()
        let db = try await rdb.database()
        return System.Permission.Query(db: db)
    }

    // MARK: -

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
                fields: [
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
                filter: filterGroup.map { .init(groups: [$0]) }
            )
        )

        return try System.Permission.List(
            items: result.items.map {
                try $0.toListItem()
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
            .map {
                try $0.toReference()
            }
    }

    public func create(
        _ input: System.Permission.Create
    ) async throws -> System.Permission.Detail {

        let queryBuilder = try await getQueryBuilder()
        try await input.validate(queryBuilder)
        let model = System.Permission.Model(
            key: input.key.toKey(),
            name: input.name,
            notes: input.notes
        )
        try await queryBuilder.insert(model)
        return try model.toDetail()
    }

    public func get(
        key: ID<System.Permission>
    ) async throws -> System.Permission.Detail {
        let queryBuilder = try await getQueryBuilder()

        guard let model = try await queryBuilder.get(key) else {
            throw System.Error.permissionNotFound
        }
        return try model.toDetail()
    }

    public func update(
        key: ID<System.Permission>,
        _ input: System.Permission.Update
    ) async throws -> System.Permission.Detail {
        let queryBuilder = try await getQueryBuilder()

        guard try await queryBuilder.get(key) != nil else {
            throw System.Error.permissionNotFound
        }
        try await input.validate(key, queryBuilder)
        let newModel = System.Permission.Model(
            key: input.key.toKey(),
            name: input.name,
            notes: input.notes
        )
        try await queryBuilder.update(key, newModel)
        return try newModel.toDetail()
    }

    public func patch(
        key: ID<System.Permission>,
        _ input: System.Permission.Patch
    ) async throws -> System.Permission.Detail {
        let queryBuilder = try await getQueryBuilder()

        guard let oldModel = try await queryBuilder.get(key) else {
            throw System.Error.permissionNotFound
        }
        try await input.validate(key, queryBuilder)
        let newModel = System.Permission.Model(
            key: input.key?.toKey() ?? oldModel.key,
            name: input.name ?? oldModel.name,
            notes: input.notes ?? oldModel.notes
        )
        try await queryBuilder.update(key, newModel)
        return try newModel.toDetail()
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
