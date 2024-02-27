import FeatherKit
import FeatherOpenAPISpec
import SystemKit
import SystemOpenAPIRuntimeKit
import SystemServerKit
import XCTest

final class SystemVariableUpdateTests: TestCase {

    func testSimpleUpdate() async throws {
        let object = try await sdk.createSystemVariable(
            .init(
                key: .init("key1"),
                value: "value1",
                name: "name1",
                notes: "notes1"
            )
        )

        try await runSpec {
            PUT("system/variables/\(object.key)")
            JSONBody(
                Components.Schemas.SystemVariableUpdate(
                    key: "key2",
                    value: "value2",
                    name: "name2",
                    notes: "notes2"
                )
            )
            JSONResponse(
                type: Components.Schemas.SystemVariableDetail.self
            ) { value in
                XCTAssertEqual(value.key, "key2")
                XCTAssertEqual(value.value, "value2")
                XCTAssertEqual(value.name, "name2")
                XCTAssertEqual(value.notes, "notes2")
            }
        }
    }
}
