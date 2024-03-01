//
//  File.swift
//
//
//  Created by Tibor Bodecs on 21/02/2024.
//

import CoreInterfaceKit
import SystemInterfaceKit

extension System.Permission.List.Sort {

    func toAPI() -> Components.Schemas.SystemPermissionListSort {
        switch self {
        case .name:
            .name
        case .key:
            .name
        }
    }
}

extension List.Result<
    System.Permission.List.Item,
    System.Permission.List.Sort
> {

    public func toAPI() -> Components.Schemas.SystemPermissionList {
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

extension System.Permission.Reference {

    public func toAPI() -> Components.Schemas.SystemPermissionReference {
        .init(
            key: key.rawValue,
            name: name
        )
    }
}

extension System.Permission.List.Item {

    public func toAPI() -> Components.Schemas.SystemPermissionListItem {
        .init(
            key: key.rawValue,
            name: name
        )
    }
}

extension System.Permission.Detail {

    public func toAPI() -> Components.Schemas.SystemPermissionDetail {
        .init(
            key: key.rawValue,
            name: name,
            notes: notes
        )
    }
}

extension System.Permission.Create {

    public func toAPI() -> Components.Schemas.SystemPermissionCreate {
        .init(
            key: key.rawValue,
            name: name,
            notes: notes
        )
    }
}

extension System.Permission.Patch {

    public func toAPI() -> Components.Schemas.SystemPermissionPatch {
        .init(
            key: key.map { $0.rawValue },
            name: name,
            notes: notes
        )
    }
}

extension System.Permission.Update {

    public func toAPI() -> Components.Schemas.SystemPermissionUpdate {
        .init(
            key: key.rawValue,
            name: name,
            notes: notes
        )
    }
}
