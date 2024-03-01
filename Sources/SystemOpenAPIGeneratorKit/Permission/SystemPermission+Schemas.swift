import FeatherOpenAPIKit
import CoreOpenAPIGeneratorKit

extension System.Permission {

    public enum Schemas: Component {

        public enum Key: TextSchema {
            public static let description = "Key of the permission"
            public static let examples = [
                "namespace.context.action"
            ]
        }

        public enum Name: TextSchema {
            public static let description = "Name of the permission"
            public static let examples = [
                "Name of the permission"
            ]
        }

        public enum Notes: TextSchema {
            public static let description = "Description of the permission"
            public static let examples = [
                "Notes for the permission"
            ]
        }

        // MARK: -

        public enum Reference: ObjectSchema {
            public static let description = ""
            public static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self),
                .init("name", Name.self),
            ]
        }

        // MARK: - list

        public enum List: ObjectSchema {

            public enum Item: ObjectSchema {
                public static let description = "Permission list item"
                public static let properties: [ObjectSchemaProperty] = [
                    .init("key", Key.self),
                    .init("name", Name.self),
                ]
            }

            public enum Items: ArraySchema {
                public static let description = "Permission list items"
                public static let items: Schema.Type = Item.self
            }

            public enum Sort: EnumSchema {
                public static let description = "The sort key for the list"
                public static let allowedValues = ["key", "name"]
                public static let defaultValue = "key"

            }

            public static let description = "Permission list"
            public static let properties: [ObjectSchemaProperty] =
                [
                    .init("items", Items.self),
                    .init("sort", Sort.self, required: false),
                ] + Feather.Core.Schemas.List.properties
        }

        // MARK: -

        public enum Detail: ObjectSchema {
            public static let description = ""
            public static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self),
                .init("name", Name.self),
                .init("notes", Notes.self, required: false),
            ]
        }

        public enum Create: ObjectSchema {
            public static let description = ""
            public static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self),
                .init("name", Name.self),
                .init("notes", Notes.self, required: false),
            ]
        }

        public enum Update: ObjectSchema {
            public static let description = ""
            public static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self),
                .init("name", Name.self),
                .init("notes", Notes.self, required: false),
            ]
        }

        public enum Patch: ObjectSchema {
            public static let description = ""
            public static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self, required: false),
                .init("name", Name.self, required: false),
                .init("notes", Notes.self, required: false),
            ]
        }

        public enum BulkDelete: ArraySchema {
            public static let description =
                "The list of the keys to be deleted."
            public static let items: Schema.Type = Key.self
        }
    }
}
