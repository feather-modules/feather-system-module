import FeatherOpenAPIKit

extension System.Variable {

    public enum Parameters: Component {

        enum Key: PathParameter {
            static let name = "key"
            static let description = "System variable key"
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
