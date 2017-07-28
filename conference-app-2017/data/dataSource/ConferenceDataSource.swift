import Cache
import OctavKit
import Result

struct ConferenceRemoteDataSource {
    static let shared = ConferenceRemoteDataSource()
    private init() {}

    func find(completion: @escaping (Result<Conference, OctavAPIError>) -> Void) {
        OctavKit.conference(completion: completion)
    }
}

struct ConferenceLocalDataSource {
    private let cache = DiskCache.shared
    private let key = "conference"

    static let shared = ConferenceLocalDataSource()
    private init() {}

    func find(completion: @escaping (Result<Conference, StorageError>) -> Void) {
        cache.read(key: key, completion: completion)
    }

    func store(_ value: Conference, completion: @escaping (Result<Void, StorageError>) -> Void) {
        let json = JSON.dictionary(value.encodeJSON())
        cache.write(json, key: key, completion: completion)
    }
}
