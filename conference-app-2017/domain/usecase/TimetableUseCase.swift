import Result
import OctavKit

struct TimetableUseCase {
    private let sessionRepository: SessionRepository
    private let conferenceRepository: ConferenceRespository

    init(
        sessionRepository: SessionRepository = SessionRepository(),
        conferenceRepository: ConferenceRespository = ConferenceRespository())
    {
        self.sessionRepository = sessionRepository
        self.conferenceRepository = conferenceRepository
    }

    func findAll(completion: @escaping (Result<[Timetable], RepositoryError>) -> Void) {
        conferenceRepository.find { result1 in
            switch result1 {
            case .success(let conference):
                self.sessionRepository.findAll { result2 in
                    switch result2 {
                    case .success(let sessions):
                        let timetables = TimetableTranslater.translate(conference: conference, sessions: sessions)
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
