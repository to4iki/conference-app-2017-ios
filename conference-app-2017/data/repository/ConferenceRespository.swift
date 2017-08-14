import OctavKit
import Result

struct ConferenceRespository {
    private let localDataStore: ConferenceLocalDataStore
    private let remoteDataStore: ConferenceRemoteDataStore

    init(
        localDataStore: ConferenceLocalDataStore = ConferenceLocalDataStore.shared,
        remoteDataStore: ConferenceRemoteDataStore = ConferenceRemoteDataStore.shared)
    {
        self.localDataStore = localDataStore
        self.remoteDataStore = remoteDataStore
    }

    func find(completion: @escaping (Result<Conference, RepositoryError>) -> Void) {
        localDataStore.find { localResult in
            if case .success(let value) = localResult {
                completion(.success(value))
            } else {
                self.remoteDataStore.find { remoteResult in
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
        remoteDataStore.find { result in
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
