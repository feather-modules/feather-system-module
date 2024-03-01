import CoreInterfaceKit
import OpenAPIRuntime
import SystemInterfaceKit

extension List.Order {

    public func toAPI() -> Components.Schemas.GenericListOrder {
        switch self {
        case .asc:
            .asc
        case .desc:
            .desc
        }
    }
}

//extension List.Page {
//
//    package func toAPI() -> Components.Schemas.GenericListPage {
//        .init(
//            limit: limit,
//            offset: offset
//        )
//    }
//}
//
//extension Components.Schemas.GenericListPage {
//
//    public func toSDK() -> List.Page {
//        .init(
//            limit: limit,
//            offset: offset
//        )
//    }
//}
