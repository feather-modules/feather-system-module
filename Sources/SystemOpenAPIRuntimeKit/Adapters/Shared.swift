import CoreInterfaceKit
import OpenAPIRuntime
import SystemInterfaceKit

/// NOTE: this needs to be here, because of the generated `Types.swift` file dependency.

// NOTE: generic extension for bulk delete input
extension [String] {

    package func toSDK<T>() -> [ID<T>] {
        map { .init($0) }
    }
}

//extension Components.Schemas.GenericSortOrder {
//
//    public func toInput() throws -> List.Order {
//        self == .desc ? .desc : .asc
//    }
//}
//
//extension Components.Schemas.GenericFilterRelation {
//
//    public func toInput<
//        T: Codable & Sendable & RawRepresentable
//    >() throws -> List.Filter<T>.Relation? {
//        .init(rawValue: rawValue)
//    }
//}
//
//extension List.Page.Response {
//
//    package func toAPI() throws -> Components.Schemas.GenericListPage {
//        .init(
//            limit: limit,
//            offset: offset,
//            count: count
//        )
//    }
//}
//
//extension Components.Schemas.GenericListPage {
//
//    public func toSDK() throws -> List.Page.Response {
//        .init(
//            limit: limit,
//            offset: offset,
//            count: count
//        )
//    }
//}
