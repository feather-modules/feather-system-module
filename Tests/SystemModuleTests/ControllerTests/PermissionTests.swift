//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

import FeatherModuleKit
import SystemModuleKit
import XCTest

@testable import SystemModule

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
        _ = try await system.permission.create(
            System.Permission.Create.mock()
        )

        let list = try await system.permission.list(
            System.Permission.List.Query(
                search: nil,
                sort: .init(by: .key, order: .asc),
                page: .init()
            )
        )

        print(list)
    }

    func testCreate() async throws {
        let detail = try await system.permission.create(
            System.Permission.Create.mock()
        )

        XCTAssertEqual(detail.key.rawValue, "foo.bar.baz")
        XCTAssertEqual(detail.name, "foo")
        XCTAssertEqual(detail.notes, "bar")
    }

    func testReference() async throws {
        let detail = try await system.permission.create(
            System.Permission.Create.mock()
        )

        let permissions = try await system.permission.reference(
            ids: [
                detail.key
            ]
        )

        XCTAssertEqual(permissions.count, 1)
        XCTAssertEqual(permissions[0].key, detail.key)
    }

    func testDetail() async throws {
        let detail = try await system.permission.create(
            System.Permission.Create.mock()
        )

        let permission = try await system.permission.get(detail.key)
        XCTAssertEqual(permission.key, detail.key)
    }

    func testUpdate() async throws {
        let detail = try await system.permission.create(
            System.Permission.Create.mock()
        )

        let permission = try await system.permission.update(
            detail.key,
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
        let detail = try await system.permission.create(
            System.Permission.Create.mock()
        )

        let permission = try await system.permission.patch(
            detail.key,
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
        let detail = try await system.permission.create(
            System.Permission.Create.mock()
        )

        try await system.permission.bulkDelete(
            ids: [detail.key]
        )

        let permissions = try await system.permission.reference(
            ids: [
                detail.key
            ]
        )
        XCTAssertTrue(permissions.isEmpty)
    }
}
