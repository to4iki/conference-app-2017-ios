import OctavKit
import RxSwift

struct FetchTimetableUseCase: ReadUseCase {
    typealias Value = [Timetable]
    private let conferenceRepository: AnyRepository<Conference>
    private let sessionRepository: AnyRepository<Session>

    init(conferenceRepository: AnyRepository<Conference>, sessionRepository: AnyRepository<Session>) {
        self.conferenceRepository = conferenceRepository
        self.sessionRepository = sessionRepository
    }

    func execute() -> Single<Value> {
        return Single.zip(conferenceRepository.find(), sessionRepository.findAll()) { result in
            TimetableTranslater.translate((conference: result.0, sessions: result.1))
        }
    }
}
