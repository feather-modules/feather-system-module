import FeatherOpenAPISpec
import SystemKit
import SystemOpenAPIRuntimeKit
import SystemServerKit
import XCTest

final class SystemPermissionListTests: TestCase {

    func testSimpleList() async throws {
        try await sdk.auth(TestUser.root()) {
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
            GET("system/permissions")
            BearerToken(token)
            JSONResponse(
                type: Components.Schemas.SystemPermissionList.self
            ) { value in
                XCTAssertFalse(value.items.isEmpty)
            }
        }
    }
}
