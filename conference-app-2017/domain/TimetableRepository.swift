import Foundation
import OctavKit
import Result


class OnMemoryStorage {
    static let shared = OnMemoryStorage()
    private init() { self.setup() }

    var timetables: [Timetable] = []
    var sponsors: [Sponsor] = []

    func setup() {
        OctavKit.conference { result1 in
            switch result1 {
            case .success(let value1):
                self.sponsors = value1.sponsors

                OctavKit.sessions { result2 in
                    switch result2 {
                    case .success(let value2):
                        self.timetables = TimetableFactory.create(
                            conference: value1,
                            sessions: value2
                        )
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "test"), object: nil)
                    case .failure(let error):
                        log.error(error.localizedDescription)
                        self.timetables = TimetableFactory.create(
                            conference: DummyData.shared.conference,
                            sessions: DummyData.shared.sessions
                        )
                    }
                }

            case .failure(let error):
                log.error(error.localizedDescription)
                self.timetables = TimetableFactory.create(
                    conference: DummyData.shared.conference,
                    sessions: DummyData.shared.sessions
                )
                self.sponsors = DummyData.shared.conference.sponsors
            }
        }
    }
}
