//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/01/2024.
//

import CoreModule
import CoreModuleKit
import DatabaseQueryKit
import FeatherComponent
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

    private func getQueryBuilder() async throws -> System.Variable.Query {
        let rdb = try await components.relationalDatabase()
        let db = try await rdb.database()
        return System.Variable.Query(db: db)
    }

    // MARK: -

    public func list(
        _ input: System.Variable.List.Query
    ) async throws -> System.Variable.List {

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

        let filterGroup = input.search.flatMap { value in
            QueryFilterGroup<System.Variable.Model.CodingKeys>(
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
                        field: .value,
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

        return try System.Variable.List(
            items: result.items.map {
                try $0.convert(to: System.Variable.List.Item.self)
            },
            count: UInt(result.total)
        )
    }

    public func reference(
        keys: [ID<System.Variable>]
    ) async throws -> [System.Variable.Reference] {

        let queryBuilder = try await getQueryBuilder()

        return
            try await queryBuilder.all(
                filter: .init(
                    field: .key,
                    operator: .in,
                    value: keys
                )
            )
            .convert(to: [System.Variable.Reference].self)
    }

    public func create(
        _ input: System.Variable.Create
    ) async throws -> System.Variable.Detail {

        let queryBuilder = try await getQueryBuilder()
        try await input.validate(queryBuilder)
        let model = try input.convert(to: System.Variable.Model.self)
        try await queryBuilder.insert(model)
        return try model.convert(to: System.Variable.Detail.self)

    }

    public func get(
        key: ID<System.Variable>
    ) async throws -> System.Variable.Detail {

        let queryBuilder = try await getQueryBuilder()
        guard let model = try await queryBuilder.get(key) else {
            throw System.Error.variableNotFound
        }
        return try model.convert(to: System.Variable.Detail.self)
    }

    public func update(
        key: ID<System.Variable>,
        _ input: System.Variable.Update
    ) async throws -> System.Variable.Detail {

        let queryBuilder = try await getQueryBuilder()

        guard try await queryBuilder.get(key) != nil else {
            throw System.Error.variableNotFound
        }
        try await input.validate(key, queryBuilder)
        let newModel = System.Variable.Model(
            key: input.key.toKey(),
            value: input.value,
            name: input.name,
            notes: input.notes
        )
        try await queryBuilder.update(key, newModel)
        return try newModel.convert(to: System.Variable.Detail.self)
    }

    public func patch(
        key: ID<System.Variable>,
        _ input: System.Variable.Patch
    ) async throws -> System.Variable.Detail {

        let queryBuilder = try await getQueryBuilder()

        guard let oldModel = try await queryBuilder.get(key) else {
            throw System.Error.variableNotFound
        }
        try await input.validate(key, queryBuilder)
        let newModel = System.Variable.Model(
            key: input.key?.toKey() ?? oldModel.key,
            value: input.value ?? oldModel.value,
            name: input.name ?? oldModel.name,
            notes: input.notes ?? oldModel.notes
        )
        try await queryBuilder.update(key, newModel)
        return try newModel.convert(to: System.Variable.Detail.self)
    }

    public func bulkDelete(
        keys: [ID<System.Variable>]
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
