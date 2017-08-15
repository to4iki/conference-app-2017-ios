import Cache
import OctavKit
import enum Result.Result
import RxSwift

struct ConferenceRemoteDataStore {
    static let shared = ConferenceRemoteDataStore()
    private init() {}

    func find() -> Single<Conference> {
        return Single.create { event in
            OctavKit.conference { result in
                switch result {
                case .success(let conference):
                    event(.success(conference))
                case .failure(let error):
                    event(.error(error))
                }
            }
            return Disposables.create()
        }
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

    func find() -> Single<Conference> {
        return Single.create { event in
            self.storage.read(key: self.key) { (result: Result<Conference, StorageError>) in
                switch result {
                case .success(let conference):
                    event(.success(conference))
                case .failure(let error):
                    event(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func store(_ value: Conference, completion: @escaping (Result<Void, StorageError>) -> Void) {
        let json = JSON.dictionary(value.encodeJSON())
        storage.write(json, key: key, completion: completion)
    }

    func store(_ value: Conference) -> Completable {
        return Completable.create { event in
            let json = JSON.dictionary(value.encodeJSON())
            self.storage.write(json, key: self.key) { result in
                switch result {
                case .success:
                    event(.completed)
                case .failure(let error):
                    event(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
