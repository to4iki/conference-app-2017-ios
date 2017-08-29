import OctavKit
import Swinject

struct DataContainer {
    static func register(container: Container) {
        container.register(AnyRepository<Conference>.self) { _ in
            AnyRepository(ConferenceRespository())
        }
        container.register(AnyRepository<Session>.self) { _ in
            AnyRepository(SessionRepository())
        }
    }
}
