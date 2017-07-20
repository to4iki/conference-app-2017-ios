import OctavKit
import Result

struct SessionRepository: Repository {
    func read(completion: @escaping (Result<[Session], RepositoryError>) -> Void) {
        OctavKitOnDiskCache.shared.readSessions { diskResult in
            if case .success(let value) = diskResult {
                completion(.success(value))
            } else {
                OctavKitOnAPI.sessions { apiResult in
                    switch apiResult {
                    case .success(let value):
                        completion(.success(value))
                        OctavKitOnDiskCache.shared.writeSessions(value) { writed in
                            if case .failure(let error) = writed {
                                log.error("disk write error: \(error.localizedDescription)")
                            }
                        }
                    case .failure(let error):
                        completion(.failure(.read(error)))
                    }
                }
            }
        }
    }

    static func warmup() {
        OctavKitOnAPI.sessions { result in
            switch result {
            case .success(let value):
                OctavKitOnDiskCache.shared.writeSessions(value) { writed in
                    if case .failure(let error) = writed {
                        log.error("disk write error: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                log.error("fetch api error: \(error.localizedDescription)")
            }
        }
    }
}
