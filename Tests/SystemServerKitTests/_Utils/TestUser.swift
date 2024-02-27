//
//  File.swift
//
//
//  Created by Tibor Bodecs on 27/02/2024.
//

import FeatherKit
import SystemInterfaceKit

struct TestUser {

    static func root() -> ACL.AuthenticatedUser {
        .init(
            accountId: "root",
            roleKeys: [
                "root"
            ],
            permissionKeys: [
                System.Permission.Permission.list.rawValue,
                System.Permission.Permission.get.rawValue,
                System.Permission.Permission.create.rawValue,
                System.Permission.Permission.update.rawValue,
                System.Permission.Permission.delete.rawValue,
                    // TODO: add other permission
            ]
        )
    }

}
