import FeatherOpenAPISpec
import SystemKit
import SystemOpenAPIRuntimeKit
import SystemServerKit
import XCTest

final class SystemPermissionGetTests: TestCase {

    func testSimpleDelete() async throws {
        let object = try await sdk.auth(TestUser.root()) {
            try await sdk.createPermission(
                .init(
                    key: .init("namespace.context.action"),
                    name: "name",
                    notes: "notes"
                )
            )
        }

        let token = try await getAuthToken()
        try await runSpec {
            GET("system/permissions/\(object.key)")
            BearerToken(token)
            JSONResponse(
                type: Components.Schemas.SystemPermissionDetail.self
            ) { item in
                XCTAssertEqual(item.key, "namespace.context.action")
            }
        }
    }
}
