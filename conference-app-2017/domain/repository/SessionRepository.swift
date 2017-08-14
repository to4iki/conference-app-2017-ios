import OctavKit
import Result

enum RepositoryError: Error {
    case find(Error)
}

struct SessionRepository {
    private let localDataStore: SessionLocalDataStore
    private let remoteDataStore: SessionRemoteDataStore

    init(
        localDataStore: SessionLocalDataStore = SessionLocalDataStore.shared,
        remoteDataStore: SessionRemoteDataStore = SessionRemoteDataStore.shared)
    {
        self.localDataStore = localDataStore
        self.remoteDataStore = remoteDataStore
    }

    func findAll(completion: @escaping (Result<[Session], RepositoryError>) -> Void) {
        localDataStore.findAll { localResult in
            if case .success(let value) = localResult {
                completion(.success(value))
            } else {
                self.remoteDataStore.findAll { remoteResult in
                    switch remoteResult {
                    case .success(let value):
                        completion(.success(value))
                        self.localDataStore.store(value) { writed in
                            if case .failure(let error) = writed {
                                log.error("store error: \(error.localizedDescription)")
                            }
                        }
                    case .failure(let error):
                        completion(.failure(.find(error)))
                    }
                }
            }
        }
    }

    func update() {
        remoteDataStore.findAll { result in
            switch result {
            case .success(let value):
                self.localDataStore.store(value) { writed in
                    if case .failure(let error) = writed {
                        log.error("store error: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                log.error("find error: \(error.localizedDescription)")
            }
        }
    }
}
