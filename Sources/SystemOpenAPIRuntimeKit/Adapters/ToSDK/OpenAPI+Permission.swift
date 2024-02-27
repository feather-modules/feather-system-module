//
//  File.swift
//
//
//  Created by Tibor Bodecs on 21/02/2024.
//

import FeatherKit
import SystemInterfaceKit

extension Components.Schemas.SystemPermissionListSort {

    public func toSDK() -> System.Permission.List.Sort {
        switch self {
        case .key: .key
        case .name: .name
        }
    }
}

extension Operations.listSystemPermission.Input.Query {

    public func toSDK() -> List.Query<System.Permission.List.Sort> {
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

extension Components.Schemas.SystemPermissionReference {

    public func toSDK() -> System.Permission.Reference {
        .init(
            key: .init(key),
            name: name
        )
    }
}

extension Components.Schemas.SystemPermissionListItem {

    public func toSDK() -> System.Permission.List.Item {
        .init(
            key: .init(key),
            name: name
        )
    }
}

extension Components.Schemas.SystemPermissionDetail {

    public func toSDK() -> System.Permission.Detail {
        .init(
            key: .init(key),
            name: name,
            notes: notes
        )
    }
}

extension Components.Schemas.SystemPermissionCreate {

    public func toSDK() -> System.Permission.Create {
        .init(
            key: .init(key),
            name: name,
            notes: notes
        )
    }
}

extension Components.Schemas.SystemPermissionPatch {

    public func toSDK() -> System.Permission.Patch {
        .init(
            key: key.map { .init($0) },
            name: name,
            notes: notes
        )
    }
}

extension Components.Schemas.SystemPermissionUpdate {

    public func toSDK() -> System.Permission.Update {
        .init(
            key: .init(key),
            name: name,
            notes: notes
        )
    }
}
