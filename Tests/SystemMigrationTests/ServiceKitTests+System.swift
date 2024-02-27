//
//  File.swift
//
//
//  Created by Tibor Bodecs on 07/01/2024.
//

import FeatherComponent
import FeatherRelationalDatabase
import FeatherRelationalDatabaseDriverSQLite
import Logging
import NIO
import SQLKit
import SystemInterfaceKit
import SystemMigrationKit
import XCTest

@testable import SystemKit

extension ServiceKitTests {

    func runSystemAccessTokenModelTest(_ db: SQLDatabase) async throws {
        let qb = System.AccessToken.Query(db: db)

        try await qb.insert(
            .init(token: "sample-access-token")
        )

        let list = try await qb.select()

        XCTAssertEqual(list.count, 1)
    }

    func runSystemPermissionModelTest(_ db: SQLDatabase) async throws {
        let qb = System.Permission.Query(db: db)

        try await qb.insert(
            .init(key: .init("namespace.context.action"), name: "test")
        )

        //        let list = try await qb.select()
        // TODO: don't run seed migrations
        //        XCTAssertEqual(list.count, 6)
    }

    func runSystemPushMessageModelTest(_ db: SQLDatabase) async throws {
        let qb = System.PushMessage.Query(db: db)

        try await qb.insert(
            [
                .init(
                    id: .init(),
                    title: "foo",
                    message: "bar",
                    topic: "baz",
                    date: .init(),
                    recipients: "foo"
                ),
                .init(
                    id: .init(),
                    title: "foo",
                    message: "bar",
                    topic: "baz",
                    date: .init(),
                    recipients: nil
                ),
            ]
        )

        let list = try await qb.select()

        XCTAssertEqual(list.count, 2)
    }
}
