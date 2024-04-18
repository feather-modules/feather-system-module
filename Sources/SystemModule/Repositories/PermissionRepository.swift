//
//  File.swift
//
//
//  Created by Tibor Bodecs on 04/02/2024.
//

import FeatherComponent
import FeatherDatabase
import FeatherModuleKit
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

    public func list(
        _ input: System.Permission.List.Query
    ) async throws -> System.Permission.List {
        let db = try await components.database().connection()

        var column: System.Permission.Model.ColumnNames
        switch input.sort.by {
        case .key:
            column = .key
        case .name:
            column = .name
        }

        let filterGroup = input.search.flatMap { value in
            DatabaseGroupFilter<System.Permission.Model.ColumnNames>(
                relation: .or,
                columns: [
                    .init(
                        column: .key,
                        operator: .like,
                        value: "%\(value)%"
                    ),
                    .init(
                        column: .name,
                        operator: .like,
                        value: "%\(value)%"
                    ),
                    .init(
                        column: .notes,
                        operator: .like,
                        value: "%\(value)%"
                    ),
                ]
            )
        }

        let result = try await System.Permission.Query.list(
            .init(
                page: .init(
                    size: input.page.size,
                    index: input.page.index
                ),
                orders: [
                    .init(
                        column: column,
                        direction: input.sort.order.queryDirection
                    )
                ],
                filter: filterGroup.map { .init(groups: [$0]) }
            ),
            on: db
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
        let db = try await components.database().connection()

        return try await System.Permission.Query
            .listAll(
                filter: .init(
                    column: .key,
                    operator: .in,
                    value: keys
                ),
                on: db
            )
            .map {
                try $0.toReference()
            }
    }

    public func create(
        _ input: System.Permission.Create
    ) async throws -> System.Permission.Detail {

        let db = try await components.database().connection()

        // TODO
        //        try await input.validate(<#T##queryBuilder: System.Permission.Query##System.Permission.Query#>)
        let model = System.Permission.Model(
            key: input.key.toKey(),
            name: input.name,
            notes: input.notes
        )
        try await System.Permission.Query.insert(model, on: db)
        return try model.toDetail()
    }

    public func get(
        key: ID<System.Permission>
    ) async throws -> System.Permission.Detail {
        let db = try await components.database().connection()

        let model = try await System.Permission.Query.require(
            key.toKey(),
            on: db
        )

        return try model.toDetail()
    }

    public func update(
        key: ID<System.Permission>,
        _ input: System.Permission.Update
    ) async throws -> System.Permission.Detail {
        let db = try await components.database().connection()

        _ = try await System.Permission.Query.require(key.toKey(), on: db)

        //        try await input.validate(key, queryBuilder)
        let newModel = System.Permission.Model(
            key: input.key.toKey(),
            name: input.name,
            notes: input.notes
        )
        try await System.Permission.Query.update(key.toKey(), newModel, on: db)
        return try newModel.toDetail()
    }

    public func patch(
        key: ID<System.Permission>,
        _ input: System.Permission.Patch
    ) async throws -> System.Permission.Detail {
        let db = try await components.database().connection()

        let oldModel = try await System.Permission.Query.require(
            key.toKey(),
            on: db
        )

        //        try await input.validate(key, queryBuilder)
        let newModel = System.Permission.Model(
            key: input.key?.toKey() ?? oldModel.key,
            name: input.name ?? oldModel.name,
            notes: input.notes ?? oldModel.notes
        )
        try await System.Permission.Query.update(key.toKey(), newModel, on: db)
        return try newModel.toDetail()
    }

    public func bulkDelete(
        keys: [ID<System.Permission>]
    ) async throws {
        let db = try await components.database().connection()
        try await System.Permission.Query.delete(
            filter: .init(
                column: .key,
                operator: .in,
                value: keys
            ),
            on: db
        )
    }
}
