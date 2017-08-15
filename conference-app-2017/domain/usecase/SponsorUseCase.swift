import OctavKit
import RxSwift

struct SponsorUseCase {
    private let conferenceRepository: ConferenceRespository

    init(conferenceRepository: ConferenceRespository = ConferenceRespository()) {
        self.conferenceRepository = conferenceRepository
    }

    func findAll() -> Single<[Int: [Sponsor]]> {
        return conferenceRepository.find().map { conference in
            SponsorTranslater.translate(conference)
        }
    }
}
