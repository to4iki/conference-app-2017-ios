import OctavKit
import Result

struct ConferenceRespository: Repository {
    func read(completion: @escaping (Result<Conference, RepositoryError>) -> Void) {
        OctavKitOnDiskCache.shared.readConference { diskResult in
            if case .success(let value) = diskResult {
                completion(.success(value))
            } else {
                OctavKitOnAPI.conference { apiResult in
                    switch apiResult {
                    case .success(let value):
                        completion(.success(value))
                        OctavKitOnDiskCache.shared.writeConference(value) { writed in
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
        OctavKitOnAPI.conference { result in
            switch result {
            case .success(let value):
                OctavKitOnDiskCache.shared.writeConference(value) { writed in
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
