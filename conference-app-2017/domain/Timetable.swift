import Foundation
import OctavKit

struct Timetable {
    let schedule: Conference.Schedule
    let tracks: [Track]
}

extension Timetable: CustomStringConvertible {
    var description: String {
        return "Timetable(schedule: \(schedule), tracks: \(tracks))"
    }
}
