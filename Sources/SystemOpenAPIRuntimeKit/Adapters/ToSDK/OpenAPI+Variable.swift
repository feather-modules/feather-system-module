//
//  File.swift
//
//
//  Created by Tibor Bodecs on 30/01/2024.
//

import FeatherKit
import OpenAPIRuntime
import SystemInterfaceKit

extension Components.Schemas.SystemVariableListSort {

    public func toSDK() -> System.Variable.List.Sort {
        switch self {
        case .key: .key
        case .name: .name
        case .value: .value
        }
    }
}

extension Operations.listSystemVariable.Input.Query {

    public func toSDK() -> List.Query<System.Variable.List.Sort> {
        .init(
            page: .init(
                size: pageSize,
                index: pageIndex
            ),
            search: search,
            sort: sort.flatMap { .init(rawValue: $0.rawValue) },
            order: order.flatMap { .init(rawValue: $0.rawValue) }
        )
    }
}

extension Components.Schemas.SystemVariableCreate {

    public func toSDK() -> System.Variable.Create {
        .init(
            key: .init(key),
            value: value,
            name: name,
            notes: notes
        )
    }
}

extension Components.Schemas.SystemVariableUpdate {

    public func toSDK() -> System.Variable.Update {
        .init(
            key: .init(key),
            value: value,
            name: name,
            notes: notes
        )
    }
}

extension Components.Schemas.SystemVariablePatch {

    public func toSDK() -> System.Variable.Patch {
        .init(
            key: key.map { .init($0) },
            value: value,
            name: name,
            notes: notes
        )
    }
}
