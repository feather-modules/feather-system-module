import FeatherOpenAPISpec
import SystemKit
import SystemOpenAPIRuntimeKit
import SystemServerKit
import XCTest

final class SystemPermissionDeleteTests: TestCase {

    func testSimpleDelete() async throws {
        let objects = try await sdk.auth(TestUser.root()) {
            [
                try await sdk.createPermission(
                    .init(
                        key: .init("namespace.context.action1"),
                        name: "name",
                        notes: "notes"
                    )
                ),
                try await sdk.createPermission(
                    .init(
                        key: .init("namespace.context.action2"),
                        name: "name",
                        notes: "notes"
                    )
                ),
            ]
        }

        let token = try await getAuthToken()
        try await runSpec {
            DELETE("system/permissions")
            BearerToken(token)
            JSONBody(
                [
                    objects[0].key
                ]
            )
            Expect(.noContent)
        }

        let list = try await sdk.auth(TestUser.root()) {
            try await sdk.listPermissions(.init(page: .init()))
        }

        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.items[0].key.rawValue, "namespace.context.action2")
    }

    func testBulkDelete() async throws {

        let objects = try await sdk.auth(TestUser.root()) {
            [
                try await sdk.createPermission(
                    .init(
                        key: .init("namespace.context.action1"),
                        name: "name",
                        notes: "notes"
                    )
                ),
                try await sdk.createPermission(
                    .init(
                        key: .init("namespace.context.action2"),
                        name: "name",
                        notes: "notes"
                    )
                ),
            ]
        }

        let token = try await getAuthToken()
        try await runSpec {
            DELETE("system/permissions")
            BearerToken(token)
            JSONBody(
                [
                    objects[0].key,
                    objects[1].key,
                ]
            )
            Expect(.noContent)
        }

        let list = try await sdk.auth(TestUser.root()) {
            try await sdk.listPermissions(.init(page: .init()))
        }
        XCTAssertTrue(list.items.isEmpty)
    }
}
