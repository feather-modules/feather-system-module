import FeatherOpenAPIKit

extension System.Variable {

    public enum PathItems: Component {

        enum Main: PathItem {
            static let path: Path = System.Variable.path
            static let get: Operation.Type? = Operations.List.self
            static let post: Operation.Type? = Operations.Create.self
            static let delete: Operation.Type? = Operations.BulkDelete.self
        }

        enum Identified: PathItem {
            static let path: Path = Main.path / Parameters.Key.path
            static let parameters: [Parameter.Type] = [
                Parameters.Key.self
            ]
            static let get: Operation.Type? = Operations.Get.self
            static let put: Operation.Type? = Operations.Update.self
            static let patch: Operation.Type? = Operations.Patch.self
        }
    }
}
