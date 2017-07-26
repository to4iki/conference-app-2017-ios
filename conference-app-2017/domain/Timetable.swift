import Foundation
import OctavKit

struct Timetable {
    let schedule: Conference.Schedule
    let tracks: [Track]
}

// MARK: - CustomStringConvertible
extension Timetable: CustomStringConvertible {
    var description: String {
        return "Timetable(schedule: \(schedule), tracks: \(tracks))"
    }
}

struct TimetableFactory {
    static func make(conference: Conference, sessions: [Session]) -> [Timetable] {
        return conference.schedules.map { (schedule: Conference.Schedule) in
            let predicate: (Session) -> Bool = { $0.startsOn.startOfDay == schedule.open.startOfDay }
            let groupedByStartOfDay = sessions.lazy.filter(predicate).groping()
            let tracks = conference.tracks.reduce([]) { (acc: [Track], value: Conference.Track) -> [Track] in
                if let sessions = groupedByStartOfDay[value.roomId] {
                    return acc + [Track(name: value.name, sessions: sessions)]
                } else {
                    return acc
                }
            }

            return Timetable(schedule: schedule, tracks: tracks)
        }
    }
}
