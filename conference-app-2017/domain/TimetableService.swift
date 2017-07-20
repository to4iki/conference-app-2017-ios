import Result
import OctavKit

struct TimetableService {
    private let sessionRepository = SessionRepository()
    private let conferenceRepository = ConferenceRespository()

    static let shared = TimetableService()
    private init() {}

    func read(completion: @escaping (Result<[Timetable], RepositoryError>) -> Void) {
        conferenceRepository.read { result1 in
            switch result1 {
            case .success(let conference):
                self.sessionRepository.read { result2 in
                    switch result2 {
                    case .success(let sessions):
                        let timetables = TimetableFactory.create(conference: conference, sessions: sessions)
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

struct TimetableFactory {
    static func create(conference: Conference, sessions: [Session]) -> [Timetable] {
        return conference.schedules.map { (schedule: Conference.Schedule) -> Timetable in
            Timetable(schedule: schedule, tracks: conference.tracks, grouped: sessions.groping())
        }
    }
}
