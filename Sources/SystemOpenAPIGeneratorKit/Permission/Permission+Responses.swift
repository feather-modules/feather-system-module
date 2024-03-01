import FeatherOpenAPIKit

extension System.Permission {

    public enum Responses: Component {

        enum List: JSONResponse {
            static let description = "System Permission list object"
            static let schema: Schema.Type = Schemas.List.self
        }

        enum Detail: JSONResponse {
            static let description = "System Permission detail object"
            static let schema: Schema.Type = Schemas.Detail.self
        }
    }
}
