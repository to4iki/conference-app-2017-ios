import OctavKit
import Swinject

struct DomainContainer {
    static func register(container: Container) {
        container.register(AnyReadUseCase<[Timetable]>.self) { r in
            let usecase = FetchTimetableUseCase(
                conferenceRepository: r.resolve(AnyRepository<Conference>.self)!,
                sessionRepository: r.resolve(AnyRepository<Session>.self)!
            )
            return AnyReadUseCase(usecase)
        }
        container.register(AnyReadUseCase<[Int: [Sponsor]]>.self) { r in
            let usecase = FetchSponsorUseCase(repository: r.resolve(AnyRepository<Conference>.self)!)
            return AnyReadUseCase(usecase)
        }
    }
}
