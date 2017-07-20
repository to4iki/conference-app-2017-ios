import Cache
import OctavKit
import Result

typealias OctavKitOnAPI = OctavKit

struct OctavKitOnDiskCache {
    private enum key: String {
        case sessions
        case conference
    }

    private let cache = DiskCache.shared

    static let shared = OctavKitOnDiskCache()
    private init() {}

    func readSessions(completion: @escaping (Result<[Session], DiskCacheError>) -> Void) {
        cache.read(key: key.sessions.rawValue, completion: completion)
    }

    func writeSessions(_ value: [Session], completion: @escaping (Result<Void, DiskCacheError>) -> Void) {
        let json = JSON.array(value.map({ $0.encodeJSON() }))
        cache.write(json, key: key.sessions.rawValue, completion: completion)
    }

    func readConference(completion: @escaping (Result<Conference, DiskCacheError>) -> Void) {
        cache.read(key: key.conference.rawValue, completion: completion)
    }

    func writeConference(_ value: Conference, completion: @escaping (Result<Void, DiskCacheError>) -> Void) {
        let json = JSON.dictionary(value.encodeJSON())
        cache.write(json, key: key.conference.rawValue, completion: completion)
    }
}
