//
//  File.swift
//
//
//  Created by Tibor Bodecs on 30/01/2024.
//

import SystemInterfaceKit

extension System.Variable.Model {

    init(_ input: System.Variable.Create) {
        self.key = input.key.rawValue
        self.value = input.value
        self.name = input.name
        self.notes = input.notes
    }

    func updated(_ input: System.Variable.Update) -> Self {
        .init(
            key: input.key.rawValue,
            value: input.value,
            name: input.name,
            notes: input.notes
        )
    }

    func patched(_ input: System.Variable.Patch) -> Self {
        .init(
            key: input.key?.rawValue ?? key,
            value: input.value ?? value,
            name: input.name ?? name,
            notes: input.notes ?? notes
        )
    }

    // MARK: -

    func toReference() -> System.Variable.Reference {
        .init(
            key: .init(key),
            value: value
        )
    }

    func toDetail() -> System.Variable.Detail {
        .init(
            key: .init(key),
            value: value,
            name: name,
            notes: notes
        )
    }

    func toListItem() -> System.Variable.List.Item {
        .init(
            key: .init(key),
            value: value,
            name: name
        )
    }

}
