import Cache
import Himotoki
import Result

enum StorageError: Error {
    case notFound
    case read(Error)
    case write(Error)
    case remove(Error)
}

protocol Storage {
    func read<T: Decodable>(key: String, completion: @escaping (Result<T, StorageError>) -> Void)
    func read<T: Decodable>(key: String, completion: @escaping (Result<[T], StorageError>) -> Void)
    func write(_ value: JSON, key: String, completion: @escaping (Result<Void, StorageError>) -> Void)
    func remove(key: String, completion: @escaping (Result<Void, StorageError>) -> Void)
    func removeAll(completion: @escaping (Result<Void, StorageError>) -> Void)
}
