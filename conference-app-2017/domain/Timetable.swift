import Foundation
import OctavKit

struct Timetable {
    let schedule: Conference.Schedule
    let tracks: [Track]

    init(schedule: Conference.Schedule, tracks: [Conference.Track], grouped: [Date: [Session]]) {
        self.schedule = schedule
        let grouped = grouped[schedule.open.startOfDay] ?? []
        self.tracks = tracks.flatMap({ Track(track: $0, grouped: grouped.groping()) })
    }
}

extension Timetable: CustomStringConvertible {
    var description: String {
        return "Timetable(schedule: \(schedule), tracks: \(tracks))"
    }
}
