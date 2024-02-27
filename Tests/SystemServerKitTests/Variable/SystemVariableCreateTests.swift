import FeatherOpenAPISpec
import SystemKit
import SystemOpenAPIRuntimeKit
import SystemServerKit
import XCTest

final class SystemVariableCreateTests: TestCase {

    func testValidCreate() async throws {
        try await runSpec {
            POST("system/variables")
            JSONBody(
                Components.Schemas.SystemVariableCreate(
                    key: "key1",
                    value: "value1",
                    name: "name1",
                    notes: "notes1"
                )
            )
            JSONResponse(
                type: Components.Schemas.SystemVariableDetail.self
            ) { value in
                XCTAssertEqual(value.key, "key1")
                XCTAssertEqual(value.value, "value1")
                XCTAssertEqual(value.name, "name1")
                XCTAssertEqual(value.notes, "notes1")
            }
        }

        let list = try await sdk.listSystemVariables(.init(page: .init()))

        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.items[0].key.rawValue, "key1")
    }
}
