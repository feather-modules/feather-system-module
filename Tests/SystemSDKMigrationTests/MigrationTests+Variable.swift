//
//  File.swift
//
//
//  Created by Tibor Bodecs on 30/01/2024.
//

import SQLiteNIO
import SystemSDKInterface
import XCTest

@testable import SystemSDK

final class SystemVariableMigrationTests: XCTestCase {

    func testBasicStructure() async throws {
//        try await runSQLDatabaseTest { db in
//
//            let qb = System.Variable.Query(db: db)
//
//            try await qb.insert(
//                [
//                    .init(key: .init("lorem"), value: "dolor"),
//                    .init(key: .init("empty-value"), value: "asdf"),
//                ]
//            )
//
//            let list = try await qb.select()
//
//            XCTAssertEqual(list.count, 2)
//
//        }
    }

    func testUniueKey() async throws {
//        try await runSQLDatabaseTest { db in
//
//            let qb = System.Variable.Query(db: db)
//
//            do {
//                try await qb.insert(
//                    [
//                        .init(key: .init("lorem"), value: "dolor"),
//                        .init(key: .init("lorem"), value: "sit"),
//                    ]
//                )
//                XCTFail("System variable key should be unique.")
//            }
//            catch let error as SQLiteError {
//                guard error.reason == .constraint else {
//                    return XCTFail("Not a constraint error.")
//                }
//                XCTAssertEqual(
//                    error.message,
//                    "UNIQUE constraint failed: system_variable.key"
//                )
//            }
//            catch {
//                XCTFail("\(error)")
//            }
//        }
    }
}
