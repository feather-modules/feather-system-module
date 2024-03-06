//
//  File.swift
//
//
//  Created by Tibor Bodecs on 27/02/2024.
//

extension System.Variable {

    public enum ACL: String {
        case list = "system.variable.list"
        case get = "system.variable.get"
        case create = "system.variable.create"
        case update = "system.variable.update"
        case delete = "system.variable.delete"
    }
}
