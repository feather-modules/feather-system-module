import FeatherOpenAPIKit
import CoreOpenAPIGeneratorKit

extension System.Variable {

    public enum Schemas: Component {

        enum Key: TextSchema {
            static let description = "Key of the system variable"
            static let examples = [
                "system.email.address"
            ]
        }

        enum Name: TextSchema {
            static let description = "Name of the system variable"
            static let examples = [
                "Sender address"
            ]
        }

        enum Value: TextSchema {
            static let description = "Value of the system variable"
            static let examples = [
                "something@mail.com"
            ]
        }

        enum Notes: TextSchema {
            static let description = "Notes of the system variable"
            static let examples = [
                "Any notes here"
            ]
        }

        // MARK: - list

        enum List: ObjectSchema {

            enum Item: ObjectSchema {
                static let description = "System variable list item"
                static let properties: [ObjectSchemaProperty] = [
                    .init("key", Key.self),
                    .init("value", Value.self),
                    .init("name", Name.self, required: false),
                ]
            }

            enum Items: ArraySchema {
                static let description = "System variable list items"
                static let items: Schema.Type = Item.self
            }

            enum Sort: EnumSchema {
                static let description = "The sort key for the list"
                static let allowedValues = ["key", "name", "value"]
                static let defaultValue = "key"
            }

            static let description = "System varaible list"
            static let properties: [ObjectSchemaProperty] =
                [
                    .init("items", Items.self),
                    .init("sort", Sort.self, required: false),
                ] + Feather.Core.Schemas.List.properties
        }

        // MARK: -

        enum Reference: ObjectSchema {
            static let description = ""
            static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self),
                .init("value", Value.self),
            ]
        }

        enum Detail: ObjectSchema {
            static let description = ""
            static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self),
                .init("value", Value.self),
                .init("name", Name.self, required: false),
                .init("notes", Notes.self, required: false),
            ]
        }

        enum BulkDelete: ArraySchema {
            static let description =
                "The list of the keys to be deleted."
            static let items: Schema.Type = Key.self
        }

        enum Create: ObjectSchema {
            static let description = ""
            static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self),
                .init("value", Value.self),
                .init("name", Name.self, required: false),
                .init("notes", Notes.self, required: false),
            ]
        }

        enum Update: ObjectSchema {
            static let description = ""
            static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self),
                .init("value", Value.self),
                .init("name", Name.self, required: false),
                .init("notes", Notes.self, required: false),
            ]
        }

        enum Patch: ObjectSchema {
            static let description = ""
            static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self, required: false),
                .init("value", Value.self, required: false),
                .init("name", Name.self, required: false),
                .init("notes", Notes.self, required: false),
            ]
        }
    }
}
