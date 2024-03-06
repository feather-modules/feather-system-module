import CoreSDKInterface

extension System.Variable: Identifiable {}

// MARK: -

public enum SystemVariableListSortKeys: SortKeyInterface {
    case key
    case value
    case name
}

public protocol SystemVariableListSort: Sortable
where
    Key == SystemVariableListSortKeys
{
}

public protocol SystemVariableListQuery: SimpleQueryInterface
where
    Sort: SystemVariableListSort
{
}

public protocol SystemVariableListItem: Codable {
    var key: ID<System.Variable> { get }
    var value: String { get }
}

public protocol SystemVariableList: SimpleList
where
    Query: SystemVariableListQuery,
    Item: SystemVariableListItem
{
}

// MARK: -

public protocol SystemVariableReference: Codable {
    var key: ID<System.Variable> { get }
    var value: String { get }
}

public protocol SystemVariableDetail: Codable {
    var key: ID<System.Variable> { get }
    var value: String { get }
    var name: String? { get }
    var notes: String? { get }
}

public protocol SystemVariableCreate: Codable {
    var key: ID<System.Variable> { get }
    var value: String { get }
    var name: String? { get }
    var notes: String? { get }
}

public protocol SystemVariableUpdate: Codable {
    var key: ID<System.Variable> { get }
    var value: String { get }
    var name: String? { get }
    var notes: String? { get }
}

public protocol SystemVariablePatch: Codable {
    var key: ID<System.Variable>? { get }
    var value: String? { get }
    var name: String? { get }
    var notes: String? { get }
}
