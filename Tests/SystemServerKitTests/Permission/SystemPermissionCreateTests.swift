import FeatherOpenAPISpec
import SystemKit
import SystemOpenAPIRuntimeKit
import SystemServerKit
import XCTest

final class SystemPermissionCreateTests: TestCase {

    func testValidCreate() async throws {
        let token = try await getAuthToken()

        try await runSpec {
            POST("system/permissions")
            BearerToken(token)
            JSONBody(
                Components.Schemas.SystemPermissionCreate(
                    key: "namespace.context.action",
                    name: "name",
                    notes: "notes"
                )
            )
            JSONResponse(
                type: Components.Schemas.SystemPermissionDetail.self
            ) { value in
                XCTAssertEqual(value.key, "namespace.context.action")
                XCTAssertEqual(value.name, "name")
                XCTAssertEqual(value.notes, "notes")
            }
        }

        let list = try await sdk.auth(TestUser.root()) {
            try await sdk.listPermissions(.init(page: .init()))
        }

        XCTAssertFalse(list.items.isEmpty)
    }
}
