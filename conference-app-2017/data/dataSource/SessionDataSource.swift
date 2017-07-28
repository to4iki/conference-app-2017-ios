import Cache
import OctavKit
import Result

struct SessionRemoteDataSource {
    static let shared = SessionRemoteDataSource()
    private init() {}

    func findAll(completion: @escaping (Result<[Session], OctavAPIError>) -> Void) {
        OctavKit.sessions(completion: completion)
    }
}

struct SessionLocalDataSource {
    private let cache = DiskCache.shared
    private let key = "sessions"

    static let shared = SessionLocalDataSource()
    private init() {}

    func findAll(completion: @escaping (Result<[Session], StorageError>) -> Void) {
        cache.read(key: key, completion: completion)
    }

    func store(_ value: [Session], completion: @escaping (Result<Void, StorageError>) -> Void) {
        let json = JSON.array(value.map({ $0.encodeJSON() }))
        cache.write(json, key: key, completion: completion)
    }
}
