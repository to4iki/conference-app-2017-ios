import Result

enum RepositoryError: Error {
    case read(Error)
}

protocol Repository {
    associatedtype Value
    func read(completion: @escaping (Result<Value, RepositoryError>) -> Void)
}
