//
//  File.swift
//
//
//  Created by Tibor Bodecs on 21/02/2024.
//

extension System.Permission {

    public enum ACL: String {
        case list = "system.permission.list"
        case get = "system.permission.get"
        case create = "system.permission.create"
        case update = "system.permission.update"
        case delete = "system.permission.delete"
    }
}
