import Cache
import Himotoki
import Result

/// hyperoslo/Cache Adapter
struct DiskCache: Storage {
    private let base = HybridCache(name: Bundle.main.bundleIdentifier!)

    static let shared = DiskCache()
    private init() {}

    func read<T: Decodable>(key: String, completion: @escaping (Result<T, StorageError>) -> Void) {
        base.async.object(forKey: key) { (json: JSON?) in
            if case .some(.dictionary(let value)) = json {
                do {
                    let result = try T.decodeValue(value)
                    completion(.success(result))
                } catch {
                    completion(.failure(.read(error)))
                }
            } else {
                completion(.failure(.notFound))
            }
        }
    }

    func read<T: Decodable>(key: String, completion: @escaping (Result<[T], StorageError>) -> Void) {
        base.async.object(forKey: key) { (json: JSON?) in
            if case .some(.array(let value)) = json {
                do {
                    let result: [T] = try decodeArray(value)
                    completion(.success(result))
                } catch {
                    completion(.failure(.read(error)))
                }
            } else {
                completion(.failure(.notFound))
            }
        }
    }

    func write(_ value: JSON, key: String, completion: @escaping (Result<Void, StorageError>) -> Void) {
        base.async.addObject(value, forKey: key) { (error: Error?) in
            if let error = error {
                completion(.failure(.write(error)))
            } else {
                completion(.success())
            }
        }
    }

    func remove(key: String, completion: @escaping (Result<Void, StorageError>) -> Void) {
        base.async.removeObject(forKey: key) { (error: Error?) in
            if let error = error {
                completion(.failure(.remove(error)))
            } else {
                completion(.success())
            }
        }
    }

    func removeAll(completion: @escaping (Result<Void, StorageError>) -> Void) {
        base.async.clear(keepingRootDirectory: true) { (error: Error?) in
            if let error = error {
                completion(.failure(.remove(error)))
            } else {
                completion(.success())
            }
        }
    }
}
