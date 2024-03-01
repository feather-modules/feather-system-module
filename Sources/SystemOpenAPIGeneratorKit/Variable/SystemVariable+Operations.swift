import FeatherOpenAPIKit
import CoreOpenAPIGeneratorKit

extension System.Variable {

    public enum Operations: Component {

        enum List: Operation {
            static let security: [SecurityScheme.Type] = .shared
            static let tag: Tag.Type = Tags.Main.self
            static let summary = "List system variables"
            static let description = """
                List available system variables
                """
            static let parameters: [Parameter.Type] =
                [
                    Parameters.List.Sort.self
                ] + Feather.Core.Parameters.List.parameters
            static let responses: [OperationResponse] = [
                .ok(Responses.List.self),
                .badRequest,
                .unsupportedMediaType,
                .unauthorized,
                .forbidden,
            ]

        }

        enum Create: Operation {
            static let security: [SecurityScheme.Type] = .shared
            static let tag: Tag.Type = Tags.Main.self
            static let summary = "Create a system variable"
            static let description = """
                Creates a new system variable
                """

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
            static let summary = "Bulk delete system variables"
            static let description = """
                Bulk delete system variables using identifiers
                """

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

        enum Get: Operation {
            static let security: [SecurityScheme.Type] = .shared
            static let tag: Tag.Type = Tags.Main.self
            static let summary = "System variable details"
            static let description = """
                Get the details of a system variable
                """

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
            static let summary = "Update a system variable"
            static let description = """
                Updates a system variable using an identifier
                """

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
            static let summary = "Patch a system variable"
            static let description = """
                Patches a system variable using an identifier
                """

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
