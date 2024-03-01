import FeatherOpenAPIKit

extension System.Variable {

    public enum Responses: Component {

        enum List: JSONResponse {
            static let description = "System variable list object"
            static let schema: Schema.Type = Schemas.List.self
        }

        enum Detail: JSONResponse {
            static let description = "System variable detail object"
            static let schema: Schema.Type = Schemas.Detail.self
        }
    }
}
