//
//  File.swift
//
//
//  Created by Tibor Bodecs on 21/02/2024.
//

import SystemInterfaceKit

extension System.Permission.Model {

    init(_ input: System.Permission.Create) {
        self.key = .init(input.key.rawValue)
        self.name = input.name
        self.notes = input.notes
    }

    func updated(_ input: System.Permission.Update) -> Self {
        .init(
            key: .init(input.key.rawValue),
            name: input.name,
            notes: input.notes
        )
    }

    func patched(_ input: System.Permission.Patch) -> Self {
        .init(
            key: input.key.map { .init($0.rawValue) } ?? key,
            name: input.name ?? name,
            notes: input.notes ?? notes
        )
    }

    // MARK: -

    func toReference() -> System.Permission.Reference {
        .init(key: .init(key.rawValue), name: name)
    }

    func toDetail() -> System.Permission.Detail {
        .init(
            key: .init(key.rawValue),
            name: name,
            notes: notes
        )
    }

    func toListItem() -> System.Permission.List.Item {
        .init(
            key: .init(key.rawValue),
            name: name
        )
    }

}
