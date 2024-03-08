//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

import CoreSDKInterface
import SystemSDKInterface
import XCTest

@testable import SystemSDK

extension System.Permission.Create {

    static func mock() -> System.Permission.Create {
        .init(
            key: .init(rawValue: "foo.bar.baz"),
            name: "foo",
            notes: "bar"
        )
    }
}

final class PermissionTests: TestCase {

    func testList() async throws {
        try await sdk.createPermission(
            System.Permission.Create.mock()
        )

        let list = try await sdk.listPermissions(
            System.Permission.List.Query(
                search: nil,
                sort: .init(by: .key, order: .asc),
                page: .init()
            )
        )

        print(list)
    }

    func testCreate() async throws {
        let detail = try await sdk.createPermission(
            System.Permission.Create.mock()
        )

        XCTAssertEqual(detail.key.rawValue, "foo.bar.baz")
        XCTAssertEqual(detail.name, "foo")
        XCTAssertEqual(detail.notes, "bar")
    }

    func testReference() async throws {
        let detail = try await sdk.createPermission(
            System.Permission.Create.mock()
        )

        let permissions = try await sdk.referencePermissions(
            keys: [
                detail.key
            ]
        )

        XCTAssertEqual(permissions.count, 1)
        XCTAssertEqual(permissions[0].key, detail.key)
    }

    func testDetail() async throws {
        let detail = try await sdk.createPermission(
            System.Permission.Create.mock()
        )

        let permission = try await sdk.getPermission(key: detail.key)
        XCTAssertEqual(permission.key, detail.key)
    }

    func testUpdate() async throws {
        let detail = try await sdk.createPermission(
            System.Permission.Create.mock()
        )

        let permission = try await sdk.updatePermission(
            key: detail.key,
            System.Permission.Update(
                key: detail.key,
                name: "name",
                notes: nil
            )
        )
        XCTAssertEqual(permission.key, detail.key)
        XCTAssertEqual(permission.name, "name")
        XCTAssertEqual(permission.notes, nil)
    }

    func testPatch() async throws {
        let detail = try await sdk.createPermission(
            System.Permission.Create.mock()
        )

        let permission = try await sdk.patchPermission(
            key: detail.key,
            System.Permission.Patch(
                key: detail.key,
                name: "name",
                notes: "notes"
            )
        )
        XCTAssertEqual(permission.key, detail.key)
        XCTAssertEqual(permission.name, "name")
        XCTAssertEqual(permission.notes, "notes")
    }

    func testDelete() async throws {
        let detail = try await sdk.createPermission(
            System.Permission.Create.mock()
        )

        try await sdk.bulkDeletePermission(
            keys: [detail.key]
        )

        let permissions = try await sdk.referencePermissions(
            keys: [
                detail.key
            ]
        )
        XCTAssertTrue(permissions.isEmpty)
    }
}
