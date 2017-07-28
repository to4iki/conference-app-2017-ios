import Cache
import Himotoki
import Result

struct LocalFile: Storage {
    static let shared = LocalFile()
    private init() {}

    func read<T: Decodable>(key: String, completion: @escaping (Result<T, StorageError>) -> Void) {
        guard let path = Resource.JSON(rawValue: key) else {
            completion(.failure(.notFound))
            return
        }
        guard let fileHandle = FileHandle(forReadingAtPath: path.filePath) else {
            completion(.failure(.notFound))
            return
        }

        DispatchQueue.global().async {
            do {
                let data = fileHandle.readDataToEndOfFile()
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let result = try T.decodeValue(json)
                completion(.success(result))
            } catch {
                completion(.failure(.read(error)))
            }
        }
    }

    func read<T: Decodable>(key: String, completion: @escaping (Result<[T], StorageError>) -> Void) {
        guard let path = Resource.JSON(rawValue: key) else {
            completion(.failure(.notFound))
            return
        }
        guard let fileHandle = FileHandle(forReadingAtPath: path.filePath) else {
            completion(.failure(.notFound))
            return
        }

        DispatchQueue.global().async {
            do {
                let data = fileHandle.readDataToEndOfFile()
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let result: [T] = try decodeArray(json)
                completion(.success(result))
            } catch {
                completion(.failure(.read(error)))
            }
        }
    }

    func write(_ value: JSON, key: String, completion: @escaping (Result<Void, StorageError>) -> Void) {
        log.debug("non implement")
    }

    func remove(key: String, completion: @escaping (Result<Void, StorageError>) -> Void) {
        log.debug("non implement")
    }

    func removeAll(completion: @escaping (Result<Void, StorageError>) -> Void) {
        log.debug("non implement")
    }
}
