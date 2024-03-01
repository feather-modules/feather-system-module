import FeatherOpenAPIKit

extension System.Permission {

    public enum RequestBodies: Component {

        enum Create: JSONBody {
            static let description = "Create request body"
            static let schema: Schema.Type = Schemas.Create.self
        }

        enum BulkDelete: JSONBody {
            static let description = "Bulk delete request body"
            static let schema: Schema.Type = Schemas.BulkDelete.self
        }

        enum Update: JSONBody {
            static let description = "Update request body"
            static let schema: Schema.Type = Schemas.Update.self
        }

        enum Patch: JSONBody {
            static let description = "Patch request body"
            static let schema: Schema.Type = Schemas.Patch.self
        }
    }
}
