import FeatherOpenAPIKit
import CoreOpenAPIGeneratorKit

extension System.Permission {

    public enum Operations: Component {

        enum List: Operation {
            static let security: [SecurityScheme.Type] = .shared
            static let tag: Tag.Type = Tags.Main.self
            static let summary = "List system permissions"
            static let description = "List available system permissions"
            static let parameters: [Parameter.Type] =
                [
                    Parameters.List.Sort.self
                ] + Feather.Core.Parameters.List.parameters
            static let responses: [OperationResponse] = [
                .ok(Responses.List.self),
                .badRequest,
                .unauthorized,
                .forbidden,
            ]
        }

        enum Create: Operation {
            static let security: [SecurityScheme.Type] = .shared
            static let tag: Tag.Type = Tags.Main.self
            static let summary = "Create a system permission"
            static let description = "Creates a new system permission"
            static let requestBody: RequestBody.Type? = RequestBodies.Create
                .self
            static let responses: [OperationResponse] = [
                .ok(Responses.Detail.self),
                .badRequest,
                .unauthorized,
                .forbidden,
                .unsupportedMediaType,
                .unprocessableContent,
            ]
        }

        enum BulkDelete: Operation {
            static let security: [SecurityScheme.Type] = .shared
            static let tag: Tag.Type = Tags.Main.self
            static let summary = "Bulk delete system permissions"
            static let description =
                "Removes multiple system permissions at once"
            static let requestBody: RequestBody.Type? = RequestBodies.BulkDelete
                .self
            static let responses: [OperationResponse] = [
                .noContent,
                .badRequest,
                .unauthorized,
                .forbidden,
                .notFound,
                .unsupportedMediaType,
                .unprocessableContent,
            ]
        }

        // MARK: -

        enum Detail: Operation {
            static let security: [SecurityScheme.Type] = .shared
            static let tag: Tag.Type = Tags.Main.self
            static let summary = "System permission details"
            static let description = "Get the details of a system permission"
            static let responses: [OperationResponse] = [
                .ok(Responses.Detail.self),
                .badRequest,
                .unauthorized,
                .forbidden,
                .notFound,
            ]
        }

        enum Update: Operation {
            static let security: [SecurityScheme.Type] = .shared
            static let tag: Tag.Type = Tags.Main.self
            static let summary = "Update a system permission"
            static let description = "Updates a system permission"
            static let parameters: [Parameter.Type] = [
                Parameters.Key.self
            ]
            static let requestBody: RequestBody.Type? = RequestBodies.Update
                .self
            static let responses: [OperationResponse] = [
                .ok(Responses.Detail.self),
                .badRequest,
                .unauthorized,
                .forbidden,
                .notFound,
                .unsupportedMediaType,
                .unprocessableContent,
            ]
        }

        enum Patch: Operation {
            static let security: [SecurityScheme.Type] = .shared
            static let tag: Tag.Type = Tags.Main.self
            static let summary = "Patch a System Permission"
            static let description = "Patch a given System Permission"
            static let parameters: [Parameter.Type] = [
                Parameters.Key.self
            ]
            static let requestBody: RequestBody.Type? = RequestBodies.Patch.self
            static let responses: [OperationResponse] = [
                .ok(Responses.Detail.self),
                .badRequest,
                .unauthorized,
                .forbidden,
                .notFound,
                .unsupportedMediaType,
                .unprocessableContent,
            ]
        }
    }
}
