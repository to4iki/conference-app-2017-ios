import OctavKit
import RxSwift

struct FetchSponsorUseCase: ReadUseCase {
    typealias Value = [Int: [Sponsor]]
    private let repository: AnyRepository<Conference>

    init(repository: AnyRepository<Conference>) {
        self.repository = repository
    }

    func execute() -> Single<Value> {
        return repository.find().map { conference in
            SponsorTranslater.translate(conference)
        }
    }
}
