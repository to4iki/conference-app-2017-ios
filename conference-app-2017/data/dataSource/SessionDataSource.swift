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
    private let key = "sessions"
    private let storage: Storage = {
        #if DEBUG
            return LocalFile.shared
        #else
            return DiskCache.shared
        #endif
    }()

    static let shared = SessionLocalDataSource()
    private init() {}

    func findAll(completion: @escaping (Result<[Session], StorageError>) -> Void) {
        storage.read(key: key, completion: completion)
    }

    func store(_ value: [Session], completion: @escaping (Result<Void, StorageError>) -> Void) {
        let json = JSON.array(value.map({ $0.encodeJSON() }))
        storage.write(json, key: key, completion: completion)
    }
}
