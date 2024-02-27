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
                System.Permission.ACL.list.rawValue,
                System.Permission.ACL.get.rawValue,
                System.Permission.ACL.create.rawValue,
                System.Permission.ACL.update.rawValue,
                System.Permission.ACL.delete.rawValue,
                    // TODO: add other permission
            ]
        )
    }

}
