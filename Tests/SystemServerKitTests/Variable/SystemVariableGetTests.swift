import FeatherOpenAPISpec
import SystemKit
import SystemOpenAPIRuntimeKit
import SystemServerKit
import XCTest

final class SystemVariableGetTests: TestCase {

    func testSimpleGet() async throws {
        let object = try await sdk.createSystemVariable(
            .init(
                key: .init("key1"),
                value: "value1",
                name: "name1",
                notes: "notes1"
            )
        )

        try await runSpec {
            GET("system/variables/\(object.key)")
            JSONResponse(
                type: Components.Schemas.SystemVariableDetail.self
            ) { item in
                XCTAssertEqual(item.key, "key1")
            }
        }
    }
}
