import Result
import OctavKit
import SwiftDate

struct TimetableService {
    private let sessionRepository = SessionRepository()
    private let conferenceRepository = ConferenceRespository()

    static let shared = TimetableService()
    private init() {}

    func read(completion: @escaping (Result<[Timetable], RepositoryError>) -> Void) {
        conferenceRepository.find { result1 in
            switch result1 {
            case .success(let conference):
                self.sessionRepository.findAll { result2 in
                    switch result2 {
                    case .success(let sessions):
                        let timetables = TimetableFactory.make(conference: conference, sessions: sessions)
                        completion(.success(timetables))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
