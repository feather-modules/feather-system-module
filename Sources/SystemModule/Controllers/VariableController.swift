//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/01/2024.
//

import FeatherComponent
import FeatherDatabase
import FeatherModuleKit
import Logging
import SystemModuleDatabaseKit
import SystemModuleKit

struct VariableController: SystemVariableInterface,
    ControllerCRUDInterface
{
    typealias ControllerModel = System.Variable

    let components: ComponentRegistry
    let system: SystemModuleInterface

    public init(
        components: ComponentRegistry,
        system: SystemModuleInterface
    ) {
        self.components = components
        self.system = system
    }

    // MARK: -

    static let listFilterColumns: [Model.ColumnNames] =
        [
            .key,
            .name,
            .value,
        ]
}
