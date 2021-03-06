import OctavKit
import Swinject

struct PresentationContainer {
    static func register(container: Container) {
        container.storyboardInitCompleted(TimetableViewController.self) { (r, c) in
            c.usecase = r.resolve(AnyReadUseCase<[Timetable]>.self)
        }
        container.storyboardInitCompleted(InformationViewController.self) { (r, c) in
            c.sponsorUsecase = r.resolve(AnyReadUseCase<[Int: [Sponsor]]>.self)
            c.venueUsecase = r.resolve(AnyReadUseCase<Venue>.self)
        }
    }
}
