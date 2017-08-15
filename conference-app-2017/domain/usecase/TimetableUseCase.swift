import OctavKit
import RxSwift

struct TimetableUseCase {
    private let conferenceRepository: ConferenceRespository
    private let sessionRepository: SessionRepository

    init(
        conferenceRepository: ConferenceRespository = ConferenceRespository(),
        sessionRepository: SessionRepository = SessionRepository())
    {
    self.conferenceRepository = conferenceRepository
        self.sessionRepository = sessionRepository
    }

    func findAll() -> Single<[Timetable]> {
        return Single.zip(conferenceRepository.find(), sessionRepository.findAll()) { result in
            TimetableTranslater.translate((conference: result.0, sessions: result.1))
        }
    }
}
