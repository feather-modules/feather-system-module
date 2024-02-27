import FeatherOpenAPISpec
import SystemKit
import SystemOpenAPIRuntimeKit
import SystemServerKit
import XCTest

final class SystemVariableDeleteAllTests: TestCase {

    func testSimpleDelete() async throws {
        let objects = [
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

        try await runSpec {
            DELETE("system/variables")
            JSONBody(
                [
                    objects[0].key
                ]
            )
            Expect(.noContent)
        }

        let list = try await sdk.listSystemVariables(.init(page: .init()))

        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.items[0].key.rawValue, "key2")
    }

    func testBulkDelete() async throws {
        let objects = [
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

        try await runSpec {
            DELETE("system/variables")
            JSONBody(
                [
                    objects[0].key,
                    objects[1].key,
                ]
            )
            Expect(.noContent)
        }

        let list = try await sdk.listSystemVariables(.init(page: .init()))

        XCTAssertTrue(list.items.isEmpty)
    }
}
