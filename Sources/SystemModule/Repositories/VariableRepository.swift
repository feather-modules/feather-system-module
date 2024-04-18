//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/01/2024.
//

import FeatherComponent
import FeatherDatabase
import FeatherModuleKit
import FeatherValidation
import Logging
import SystemModuleDatabaseKit
import SystemModuleKit

struct VariableRepository: SystemVariableInterface {

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
        _ input: System.Variable.List.Query
    ) async throws -> System.Variable.List {
        let db = try await components.database().connection()

        var column: System.Variable.Model.ColumnNames
        switch input.sort.by {
        case .key:
            column = .key
        case .name:
            column = .name
        case .value:
            column = .value
        }

        let filterGroup = input.search.flatMap { value in
            DatabaseGroupFilter<System.Variable.Model.ColumnNames>(
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
                        column: .value,
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

        let result = try await System.Variable.Query.list(
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

        return try System.Variable.List(
            items: result.items.map {
                try $0.toListItem()
            },
            count: UInt(result.total)
        )
    }

    public func reference(
        keys: [ID<System.Variable>]
    ) async throws -> [System.Variable.Reference] {
        let db = try await components.database().connection()
        return try await System.Variable.Query
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
        _ input: System.Variable.Create
    ) async throws -> System.Variable.Detail {

        let db = try await components.database().connection()
        //        try await input.validate(queryBuilder)
        let model = System.Variable.Model(
            key: input.key.toKey(),
            value: input.value,
            name: input.name,
            notes: input.notes
        )
        try await System.Variable.Query.insert(model, on: db)
        return try model.toDetail()

    }

    public func get(
        key: ID<System.Variable>
    ) async throws -> System.Variable.Detail {

        let db = try await components.database().connection()
        let model = try await System.Variable.Query.require(key.toKey(), on: db)

        return try model.toDetail()
    }

    public func update(
        key: ID<System.Variable>,
        _ input: System.Variable.Update
    ) async throws -> System.Variable.Detail {

        let db = try await components.database().connection()

        _ = try await System.Variable.Query.require(key.toKey(), on: db)

        //        try await input.validate(key, queryBuilder)
        let newModel = System.Variable.Model(
            key: input.key.toKey(),
            value: input.value,
            name: input.name,
            notes: input.notes
        )
        try await System.Variable.Query.update(key.toKey(), newModel, on: db)
        return try newModel.toDetail()
    }

    public func patch(
        key: ID<System.Variable>,
        _ input: System.Variable.Patch
    ) async throws -> System.Variable.Detail {

        let db = try await components.database().connection()

        let oldModel = try await System.Variable.Query.require(
            key.toKey(),
            on: db
        )

        //        try await input.validate(key, queryBuilder)
        let newModel = System.Variable.Model(
            key: input.key?.toKey() ?? oldModel.key,
            value: input.value ?? oldModel.value,
            name: input.name ?? oldModel.name,
            notes: input.notes ?? oldModel.notes
        )
        try await System.Variable.Query.update(key.toKey(), newModel, on: db)
        return try newModel.toDetail()
    }

    public func bulkDelete(
        keys: [ID<System.Variable>]
    ) async throws {
        let db = try await components.database().connection()
        try await System.Variable.Query.delete(
            filter: .init(
                column: .key,
                operator: .in,
                value: keys
            ),
            on: db
        )
    }
}
