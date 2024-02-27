import FeatherOpenAPISpec
import SystemKit
import SystemOpenAPIRuntimeKit
import SystemServerKit
import XCTest

final class SystemVariableListTests: TestCase {

    func testSimpleList() async throws {
        try await sdk.auth(TestUser.root()) {
            [
                try await sdk.createSystemVariable(
                    .init(
                        key: .init("key1"),
                        value: "value1",
                        name: "name1",
                        notes: "notes1"
                    )
                ),
                try await sdk.createSystemVariable(
                    .init(
                        key: .init("key2"),
                        value: "value2",
                        name: "name2",
                        notes: "notes2"
                    )
                ),
            ]
        }

        let token = try await getAuthToken()
        try await runSpec {
            GET("system/variables")
            BearerToken(token)
            JSONResponse(
                type: Components.Schemas.SystemPermissionList.self
            ) { value in
                XCTAssertFalse(value.items.isEmpty)
            }
        }
    }
}
