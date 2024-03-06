//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

import SystemSDKInterface
import XCTest

@testable import SystemSDK

final class PermissionTests: TestCase {

    func testExample() async throws {

        let detail = try await sdk.createPermission(
            System.Permission.Create(
                key: .init(rawValue: "foo.bar.baz"),
                name: "foo",
                notes: "bar"
            )
        )

        XCTAssertEqual(detail.name, "foo")
    }
}
