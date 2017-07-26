import OctavKit
import Result

enum RepositoryError: Error {
    case find(Error)
}

struct SessionRepository {
    private let localDataSource: SessionLocalDataSource
    private let remoteDataSource: SessionRemoteDataSource

    init(
        localDataSource: SessionLocalDataSource = SessionLocalDataSource.shared,
        remoteDataSource: SessionRemoteDataSource = SessionRemoteDataSource.shared)
    {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }

    func findAll(completion: @escaping (Result<[Session], RepositoryError>) -> Void) {
        localDataSource.findAll { localResult in
            if case .success(let value) = localResult {
                completion(.success(value))
            } else {
                self.remoteDataSource.findAll { remoteResult in
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
        remoteDataSource.findAll { result in
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
