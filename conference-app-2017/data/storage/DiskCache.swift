import Cache
import Himotoki
import Result

enum DiskCacheError: Error {
    case notFound
    case read(Error)
    case write(Error)
    case remove(Error)
}

/// hyperoslo/Cache Adapter
struct DiskCache {
    private let base = HybridCache(name: Bundle.main.bundleIdentifier!)

    static let shared = DiskCache()
    private init() {}

    func read<T: Decodable>(key: String, completion: @escaping (Result<T, DiskCacheError>) -> Void) {
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

    func read<T: Decodable>(key: String, completion: @escaping (Result<[T], DiskCacheError>) -> Void) {
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

    func write(_ value: JSON, key: String, completion: @escaping (Result<Void, DiskCacheError>) -> Void) {
        base.async.addObject(value, forKey: key) { (error: Error?) in
            if let error = error {
                completion(.failure(.write(error)))
            } else {
                completion(.success())
            }
        }
    }

    func remove(key: String, completion: @escaping (Result<Void, DiskCacheError>) -> Void) {
        base.async.removeObject(forKey: key) { (error: Error?) in
            if let error = error {
                completion(.failure(.remove(error)))
            } else {
                completion(.success())
            }
        }
    }

    func removeAll(completion: @escaping (Result<Void, DiskCacheError>) -> Void) {
        base.async.clear(keepingRootDirectory: true) { (error: Error?) in
            if let error = error {
                completion(.failure(.remove(error)))
            } else {
                completion(.success())
            }
        }
    }
}
