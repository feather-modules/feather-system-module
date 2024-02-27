import FeatherKit
import FeatherOpenAPISpec
import SystemKit
import SystemOpenAPIRuntimeKit
import SystemServerKit
import XCTest

final class SystemPermissionPatchTests: TestCase {

    func testSimplePatch() async throws {
        let object = try await sdk.auth(TestUser.root()) {
            try await sdk.createSystemPermission(
                .init(
                    key: .init("namespace.context.action1"),
                    name: "name1",
                    notes: "notes1"
                )
            )
        }

        let token = try await getAuthToken()
        try await runSpec {
            PATCH("system/permissions/\(object.key)")
            BearerToken(token)
            JSONBody(
                Components.Schemas.SystemPermissionPatch(
                    key: "namespace.context.action2",
                    name: "name2",
                    notes: "notes2"
                )
            )
            JSONResponse(
                type: Components.Schemas.SystemPermissionDetail.self
            ) { value in
                XCTAssertEqual(value.key, "namespace.context.action2")
                XCTAssertEqual(value.name, "name2")
                XCTAssertEqual(value.notes, "notes2")
            }
        }
    }
}
