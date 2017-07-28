import OctavKit
import Result

struct ConferenceRespository {
    private let localDataSource: ConferenceLocalDataSource
    private let remoteDataSource: ConferenceRemoteDataSource

    init(
        localDataSource: ConferenceLocalDataSource = ConferenceLocalDataSource.shared,
        remoteDataSource: ConferenceRemoteDataSource = ConferenceRemoteDataSource.shared)
    {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }

    func find(completion: @escaping (Result<Conference, RepositoryError>) -> Void) {
        localDataSource.find { localResult in
            if case .success(let value) = localResult {
                completion(.success(value))
            } else {
                self.remoteDataSource.find { remoteResult in
                    switch remoteResult {
                    case .success(let value):
                        completion(.success(value))
                        self.localDataSource.store(value) { writed in
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
        remoteDataSource.find { result in
            switch result {
            case .success(let value):
                self.localDataSource.store(value) { writed in
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
