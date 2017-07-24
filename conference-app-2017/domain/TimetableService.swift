import Result
import OctavKit
import SwiftDate

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
        return conference.schedules.map { (schedule: Conference.Schedule) in
            let grouped = sessions.filter { (session: Session) in
                session.startsOn.startOfDay == schedule.open.startOfDay
            }.groping()

            let tracks = conference.tracks.reduce([]) { (acc: [Track], value: Conference.Track) -> [Track] in
                if let sessions = grouped[value.roomId] {
                    return acc + [Track(name: value.name, sessions: sessions)]
                } else {
                    return acc
                }
            }

            return Timetable(schedule: schedule, tracks: tracks)
        }
    }
}
