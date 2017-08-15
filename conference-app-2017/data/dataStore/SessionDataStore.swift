import Cache
import OctavKit
import enum Result.Result
import RxSwift

struct SessionRemoteDataStore {
    static let shared = SessionRemoteDataStore()
    private init() {}

    func findAll() -> Single<[Session]> {
        return Single.create { event in
            OctavKit.sessions { result in
                switch result {
                case .success(let sessions):
                    event(.success(sessions))
                case .failure(let error):
                    event(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}

struct SessionLocalDataStore {
    private let key = "sessions"
    private let storage: Storage = {
        #if DEBUG
            return LocalFile.shared
        #else
            return DiskCache.shared
        #endif
    }()

    static let shared = SessionLocalDataStore()
    private init() {}

    func findAll() -> Single<[Session]> {
        return Single.create { event in
            self.storage.read(key: self.key) { (result: Result<[Session], StorageError>) in
                switch result {
                case .success(let sessions):
                    event(.success(sessions))
                case .failure(let error):
                    event(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func store(_ value: [Session]) -> Completable {
        return Completable.create { event in
            let json = JSON.array(value.map({ $0.encodeJSON() }))
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
