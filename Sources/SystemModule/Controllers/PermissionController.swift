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

extension System.Permission: ControllerModelInterface {}

struct PermissionController: SystemPermissionInterface,
    ControllerCRUDInterface
{
    typealias ControllerModel = System.Permission

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
