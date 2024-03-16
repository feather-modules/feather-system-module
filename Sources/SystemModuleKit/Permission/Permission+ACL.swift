//
//  File.swift
//
//
//  Created by Tibor Bodecs on 21/02/2024.
//

import CoreModuleKit

extension Permission {

    static func systemPermission(_ action: Action) -> Self {
        .system("permission", action: action)
    }
}

extension System.Permission {

    public enum ACL: ACLSet {

        public static let list: Permission = .systemPermission(.list)
        public static let detail: Permission = .systemPermission(.detail)
        public static let create: Permission = .systemPermission(.create)
        public static let update: Permission = .systemPermission(.update)
        public static let delete: Permission = .systemPermission(.delete)

        public static var all: [Permission] = [
            Self.list,
            Self.detail,
            Self.create,
            Self.update,
            Self.delete,
        ]
    }
}
