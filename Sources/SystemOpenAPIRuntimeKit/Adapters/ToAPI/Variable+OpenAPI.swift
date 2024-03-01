//
//  File.swift
//
//
//  Created by Tibor Bodecs on 30/01/2024.
//

import CoreInterfaceKit
import OpenAPIRuntime
import SystemInterfaceKit

extension System.Variable.List.Sort {

    func toAPI() -> Components.Schemas.SystemVariableListSort {
        switch self {
        case .key: .key
        case .name: .name
        case .value: .value
        }
    }
}

extension List.Result<
    System.Variable.List.Item,
    System.Variable.List.Sort
> {

    public func toAPI() -> Components.Schemas.SystemVariableList {
        .init(
            items: items.map { $0.toAPI() },
            sort: query.sort?.toAPI(),
            order: query.order?.toAPI(),
            search: query.search,
            page: .init(size: query.page.size, index: query.page.index),
            count: count
        )
    }
}

extension System.Variable.Detail {

    public func toAPI() -> Components.Schemas.SystemVariableDetail {
        .init(
            key: key.rawValue,
            value: value,
            name: name,
            notes: notes
        )
    }
}

extension System.Variable.Create {

    public func toAPI() -> Components.Schemas.SystemVariableCreate {
        .init(
            key: key.rawValue,
            value: value,
            name: name,
            notes: notes
        )
    }
}

extension System.Variable.Update {

    public func toAPI() -> Components.Schemas.SystemVariableUpdate {
        .init(
            key: key.rawValue,
            value: value,
            name: name,
            notes: notes
        )
    }
}

extension System.Variable.Patch {

    public func toAPI() -> Components.Schemas.SystemVariablePatch {
        .init(
            key: key.map { $0.rawValue },
            value: value,
            name: name,
            notes: notes
        )
    }
}

extension System.Variable.List.Item {

    public func toAPI() -> Components.Schemas.SystemVariableListItem {
        .init(
            key: key.rawValue,
            value: value,
            name: name
        )
    }
}
