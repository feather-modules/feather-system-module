import FeatherOpenAPIKit
import FeatherOpenAPIKitMacros

extension System.Variable {

    public enum Schemas {

        public enum Key: TextSchema {
            public static let description = "Key of the system variable"
            public static let examples = [
                "system.email.address"
            ]
        }

        public enum Name: TextSchema {
            public static let description = "Name of the system variable"
            public static let examples = [
                "Sender address"
            ]
        }

        public enum Value: TextSchema {
            public static let description = "Value of the system variable"
            public static let examples = [
                "something@mail.com"
            ]
        }

        public enum Notes: TextSchema {
            public static let description = "Notes of the system variable"
            public static let examples = [
                "Any notes here"
            ]
        }

        // MARK: - list

        public enum List: ObjectSchema {

            public enum Item: ObjectSchema {
                public static let description = "System variable list item"
                public static let properties: [ObjectSchemaProperty] = [
                    .init("key", Key.self),
                    .init("value", Value.self),
                    .init("name", Name.self, required: false),
                ]
            }

            public enum Items: ArraySchema {
                public static let description = "System variable list items"
                public static let items: Schema.Type = Item.self
            }

            public enum Sort: EnumSchema {
                public static let description = "The sort key for the list"
                public static let allowedValues = ["key", "name", "value"]
                public static let defaultValue = "key"
            }

            public static let description = "System varaible list"
            public static let properties: [ObjectSchemaProperty] =
                [
                    .init("items", Items.self),
                    .init("sort", Sort.self, required: false),
                ] + Generic.Component.Schemas.List.properties
        }

        // MARK: -

        public enum Reference: ObjectSchema {
            public static let description = ""
            public static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self),
                .init("value", Value.self),
            ]
        }

        public enum Detail: ObjectSchema {
            public static let description = ""
            public static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self),
                .init("value", Value.self),
                .init("name", Name.self, required: false),
                .init("notes", Notes.self, required: false),
            ]
        }

        public enum BulkDelete: ArraySchema {
            public static let description =
                "The list of the keys to be deleted."
            public static let items: Schema.Type = Key.self
        }

        public enum Create: ObjectSchema {
            public static let description = ""
            public static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self),
                .init("value", Value.self),
                .init("name", Name.self, required: false),
                .init("notes", Notes.self, required: false),
            ]
        }

        public enum Update: ObjectSchema {
            public static let description = ""
            public static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self),
                .init("value", Value.self),
                .init("name", Name.self, required: false),
                .init("notes", Notes.self, required: false),
            ]
        }

        public enum Patch: ObjectSchema {
            public static let description = ""
            public static let properties: [ObjectSchemaProperty] = [
                .init("key", Key.self, required: false),
                .init("value", Value.self, required: false),
                .init("name", Name.self, required: false),
                .init("notes", Notes.self, required: false),
            ]
        }
    }
}
