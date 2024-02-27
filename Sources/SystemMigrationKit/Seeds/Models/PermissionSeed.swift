//
//  File.swift
//
//
//  Created by Tibor Bodecs on 27/02/2024.
//

public struct PermissionSeed: Codable {

    public let key: String
    public let name: String
    public let notes: String?

    public init(key: String, name: String, notes: String? = nil) {
        self.key = key
        self.name = name
        self.notes = notes
    }
}
