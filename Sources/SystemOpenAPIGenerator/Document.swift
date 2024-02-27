import FeatherOpenAPIKit
import Foundation
import OpenAPIKit
import SystemOpenAPIGeneratorKit

struct OpenAPIDocument: Document {

    let components =
        FeatherOpenAPIKit.ComponentCollector.components
        + SystemOpenAPIGeneratorKit.ComponentCollector.components

    func openAPIDocument() -> OpenAPI.Document {
        let dateString = DateFormatter.localizedString(
            from: Date(),
            dateStyle: .medium,
            timeStyle: .medium
        )

        return composedDocument(
            info: .init(
                title: "System - API",
                description: """
                    The entire API definition of the system module.
                    (Generated on: \(dateString))
                    """,
                contact: .init(
                    name: "Binary Birds",
                    url: .init(string: "https://binarybirds.com")!,
                    email: "info@binarybirds.com"
                ),
                version: "1.0.0"
            ),
            servers: [
                .init(
                    url: .init(string: "http://localhost:8080")!,
                    description: "dev"
                ),
                .init(
                    url: .init(string: "http://localhost:8081")!,
                    description: "live"
                ),
            ]
        )
    }
}
