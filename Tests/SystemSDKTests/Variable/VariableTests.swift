//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

import CoreSDKInterface
import FeatherValidation
import SystemSDKInterface
import XCTest

@testable import SystemSDK

extension System.Variable.Create {

    static func mock(_ i: Int = 1) -> System.Variable.Create {
        .init(
            key: .init(rawValue: "key-\(i)"),
            value: "value-\(i)",
            name: "name-\(i)",
            notes: "notes-\(i)"
        )
    }
}

final class VariableTests: TestCase {

    func testList() async throws {
        _ = try await sdk.variable.create(
            System.Variable.Create.mock()
        )

        let list = try await sdk.variable.list(
            .init(
                search: nil,
                sort: .init(by: .key, order: .asc),
                page: .init()
            )
        )

        print(list)
    }

    func testCreate() async throws {
        let detail = try await sdk.variable.create(
            System.Variable.Create.mock()
        )

        XCTAssertEqual(detail.key.rawValue, "key-1")
        XCTAssertEqual(detail.value, "value-1")
        XCTAssertEqual(detail.name, "name-1")
        XCTAssertEqual(detail.notes, "notes-1")
    }

    func testCreateInvalid() async throws {
        do {
            _ = try await sdk.variable.create(
                .init(
                    key: .init(rawValue: "a"),
                    value: "",
                    name: nil,
                    notes: nil
                )
            )
            XCTFail("Validation test should fail.")
        }
        catch let error as ValidatorError {
            XCTAssertEqual(error.failures.count, 2)
            let keys = error.failures.map(\.key).sorted()
            XCTAssertEqual(keys, ["key", "value"])
        }
        catch {
            XCTFail("\(error)")
        }
    }

    func testCreateInvalidUnique() async throws {
        _ = try await sdk.variable.create(
            System.Variable.Create.mock()
        )

        do {
            _ = try await sdk.variable.create(
                .init(
                    key: .init(rawValue: "key-1"),
                    value: "",
                    name: nil,
                    notes: nil
                )
            )
            XCTFail("Validation test should fail.")
        }
        catch let error as ValidatorError {
            XCTAssertEqual(error.failures.count, 2)
            let keys = error.failures.map(\.key).sorted()
            XCTAssertEqual(keys, ["key", "value"])
        }
        catch {
            XCTFail("\(error)")
        }
    }

    func testReference() async throws {
        let detail = try await sdk.variable.create(
            System.Variable.Create.mock()
        )

        let variables = try await sdk.variable.reference(
            keys: [
                detail.key
            ]
        )

        XCTAssertEqual(variables.count, 1)
        XCTAssertEqual(variables[0].key, detail.key)
    }

    func testDetail() async throws {
        let detail = try await sdk.variable.create(
            System.Variable.Create.mock()
        )

        let variable = try await sdk.variable.get(key: detail.key)
        XCTAssertEqual(variable.key, detail.key)
    }

    func testUpdate() async throws {
        let detail = try await sdk.variable.create(
            System.Variable.Create.mock()
        )

        let variable = try await sdk.variable.update(
            key: detail.key,
            .init(
                key: detail.key,
                value: "value-2",
                name: "name-2",
                notes: nil
            )
        )
        XCTAssertEqual(variable.key, detail.key)
        XCTAssertEqual(variable.value, "value-2")
        XCTAssertEqual(variable.name, "name-2")
        XCTAssertEqual(variable.notes, nil)
    }
    
    func testUpdateInvalidUnique() async throws {
        let detail1 = try await sdk.variable.create(
            System.Variable.Create.mock(1)
        )
        let detail2 = try await sdk.variable.create(
            System.Variable.Create.mock(2)
        )

        do {
            _ = try await sdk.variable.update(
                key: detail1.key,
                .init(
                    key: detail2.key,
                    value: "",
                    name: nil,
                    notes: nil
                )
            )
            XCTFail("Validation test should fail.")
        }
        catch let error as ValidatorError {
            XCTAssertEqual(error.failures.count, 2)
            let keys = error.failures.map(\.key).sorted()
            XCTAssertEqual(keys, ["key", "value"])
        }
        catch {
            XCTFail("\(error)")
        }
    }

    func testPatch() async throws {
        let detail = try await sdk.variable.create(
            System.Variable.Create.mock()
        )

        let variable = try await sdk.variable.patch(
            key: detail.key,
            .init(
                key: detail.key,
                name: "name-2",
                notes: "notes-2"
            )
        )
        XCTAssertEqual(variable.key, detail.key)
        XCTAssertEqual(variable.value, "value-1")
        XCTAssertEqual(variable.name, "name-2")
        XCTAssertEqual(variable.notes, "notes-2")
    }
    
    func testPatchValidUnique() async throws {
        let detail = try await sdk.variable.create(
            System.Variable.Create.mock()
        )

        let variable = try await sdk.variable.patch(
            key: detail.key,
            .init(
                key: .init(rawValue: "id-2"),
                name: "name-2",
                notes: "notes-2"
            )
        )
        do {
            _ = try await sdk.variable.get(key: detail.key)
        }
        catch System.Error.variableNotFound {
            // ok
        }
        catch {
            XCTFail("\(error)")
        }

        XCTAssertEqual(variable.key, .init(rawValue: "id-2"))
        XCTAssertEqual(variable.value, "value-1")
        XCTAssertEqual(variable.name, "name-2")
        XCTAssertEqual(variable.notes, "notes-2")
    }
    
    func testPatchInvalidUnique() async throws {
        let detail1 = try await sdk.variable.create(
            System.Variable.Create.mock(1)
        )
        let detail2 = try await sdk.variable.create(
            System.Variable.Create.mock(2)
        )

        do {
            _ = try await sdk.variable.patch(
                key: detail1.key,
                .init(
                    key: detail2.key,
                    value: "",
                    name: nil,
                    notes: nil
                )
            )
            XCTFail("Validation test should fail.")
        }
        catch let error as ValidatorError {
            XCTAssertEqual(error.failures.count, 2)
            let keys = error.failures.map(\.key).sorted()
            XCTAssertEqual(keys, ["key", "value"])
        }
        catch {
            XCTFail("\(error)")
        }
    }

    func testDelete() async throws {
        let detail = try await sdk.variable.create(
            System.Variable.Create.mock()
        )

        try await sdk.variable.bulkDelete(
            keys: [detail.key]
        )

        let variables = try await sdk.variable.reference(
            keys: [
                detail.key
            ]
        )
        XCTAssertTrue(variables.isEmpty)
    }
}
