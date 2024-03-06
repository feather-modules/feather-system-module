import CoreSDKInterface

extension System.Permission: Identifiable {}

// MARK: -

public enum SystemPermissionListSortKeys: SortKeyInterface {
    case key
    case name
}

public protocol SystemPermissionListSort: Sortable
where
    Key == SystemPermissionListSortKeys
{
}

public protocol SystemPermissionListQuery: SimpleQueryInterface
where
    Sort: SystemPermissionListSort
{
}

public protocol SystemPermissionListItem: Codable {
    var key: ID<System.Permission> { get }
    var name: String { get }
}

public protocol SystemPermissionList: SimpleList
where
    Query: SystemPermissionListQuery,
    Item: SystemPermissionListItem
{
}

// MARK: -

public protocol SystemPermissionReference: Codable {
    var key: ID<System.Permission> { get }
    var name: String { get }
}

public protocol SystemPermissionDetail: Codable {
    var key: ID<System.Permission> { get }
    var name: String { get }
    var notes: String? { get }
}

public protocol SystemPermissionCreate: Codable {
    var key: ID<System.Permission> { get }
    var name: String { get }
    var notes: String? { get }
}

public protocol SystemPermissionUpdate: Codable {
    var key: ID<System.Permission> { get }
    var name: String { get }
    var notes: String? { get }
}

public protocol SystemPermissionPatch: Codable {
    var key: ID<System.Permission>? { get }
    var name: String? { get }
    var notes: String? { get }
}
