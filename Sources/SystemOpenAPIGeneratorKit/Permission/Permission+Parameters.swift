import FeatherOpenAPIKit

extension System.Permission {

    public enum Parameters: Component {

        enum Key: PathParameter {
            static let name = "permissionKey"
            static let description = "System permission key"
            static let schema: Schema.Type = Schemas.Key.self
        }

        enum List {
            enum Sort: QueryParameter {
                static let name = "sort"
                static let description = "Sort by parameter"
                static let schema: Schema.Type = Schemas.List.Sort.self
            }
        }
    }
}
