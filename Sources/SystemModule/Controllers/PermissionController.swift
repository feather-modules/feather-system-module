//
//  File.swift
//
//
//  Created by Tibor Bodecs on 04/02/2024.
//

import FeatherComponent
import FeatherDatabase
import FeatherModuleKit
import FeatherValidation
import Logging
import SystemModuleDatabaseKit
import SystemModuleKit

struct PermissionController: SystemPermissionInterface,
    ControllerList,
    ControllerReference,
    ControllerCreate,
    ControllerGet,
    ControllerUpdate,
    ControllerPatch,
    ControllerDelete
{
    typealias Query = System.Permission.Query
    typealias Patch = System.Permission.Patch
    typealias Update = System.Permission.Update
    typealias Create = System.Permission.Create
    typealias Detail = System.Permission.Detail
    typealias Reference = System.Permission.Reference
    typealias List = System.Permission.List

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
            .notes,
        ]
}
