//
//  File.swift
//
//
//  Created by Tibor Bodecs on 27/02/2024.
//

import FeatherACL

extension Permission {

    static func systemVariable(_ action: Action) -> Self {
        .system("variable", action: action)
    }
}

extension System.Variable {

    public enum ACL: ACLSet {

        public static let list: Permission = .systemVariable(.list)
        public static let detail: Permission = .systemVariable(.detail)
        public static let create: Permission = .systemVariable(.create)
        public static let update: Permission = .systemVariable(.update)
        public static let delete: Permission = .systemVariable(.delete)

        public static var all: [Permission] = [
            Self.list,
            Self.detail,
            Self.create,
            Self.update,
            Self.delete,
        ]
    }
}
