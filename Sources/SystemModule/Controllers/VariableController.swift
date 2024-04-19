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
    ControllerList,
    ControllerReference,
    ControllerCreate,
    ControllerGet,
    ControllerUpdate,
    ControllerPatch,
    ControllerDelete
{
    typealias Query = System.Variable.Query
    typealias Patch = System.Variable.Patch
    typealias Update = System.Variable.Update
    typealias Create = System.Variable.Create
    typealias Detail = System.Variable.Detail
    typealias Reference = System.Variable.Reference
    typealias List = System.Variable.List

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

    static func getListFilterColumns() -> [Model.ColumnNames] {
        [
            .key,
            .name,
            .value,
        ]
    }
}
