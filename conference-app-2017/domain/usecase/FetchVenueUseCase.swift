import OctavKit
import RxSwift

struct FetchVenueUseCase: ReadUseCase {
    typealias Value = Venue
    private let repository: AnyRepository<Conference>

    init(repository: AnyRepository<Conference>) {
        self.repository = repository
    }

    func execute() -> Single<Venue> {
        return repository.find().map { conference in
            assert(conference.venues.isEmpty, "Set conference.venue!")
            return VenueTranslater.translate(conference.venues.first!)
        }
    }
}
