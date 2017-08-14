import Cache
import OctavKit
import Result

struct ConferenceRemoteDataStore {
    static let shared = ConferenceRemoteDataStore()
    private init() {}

    func find(completion: @escaping (Result<Conference, OctavAPIError>) -> Void) {
        OctavKit.conference(completion: completion)
    }
}

struct ConferenceLocalDataStore {
    private let key = "conference"
    private let storage: Storage = {
        #if DEBUG
            return LocalFile.shared
        #else
            return DiskCache.shared
        #endif
    }()

    static let shared = ConferenceLocalDataStore()
    private init() {}

    func find(completion: @escaping (Result<Conference, StorageError>) -> Void) {
        storage.read(key: key, completion: completion)
    }

    func store(_ value: Conference, completion: @escaping (Result<Void, StorageError>) -> Void) {
        let json = JSON.dictionary(value.encodeJSON())
        storage.write(json, key: key, completion: completion)
    }
}
