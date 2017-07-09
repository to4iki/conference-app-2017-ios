import Foundation
import OctavKit
import SwiftDate

struct Track: CustomStringConvertible {
    let room: Room
    let sessions: [Session]

    var description: String {
        return "Track(room: \(room), sessions: \(sessions))"
    }
}

struct Timetable: CustomStringConvertible {
    let date: Date
    let tracks: [Track]

    var startToEnd: (start: Date, end: Date) {
        let sessions = tracks.flatMap({ $0.sessions })
        let min = sessions.min(by: { (before, after) in before.startsOn < after.startsOn })!
        let max = sessions.max(by: { (before, after) in before.startsOn < after.startsOn })!
        return (start: min.startsOn, end: max.startsOn + Int(max.duration).second)
    }

    var duration: Int {
        let (start, end) = startToEnd
        return Int(end - start)
    }

    var description: String {
        return "Timetable(date: \(date), tracks: \(tracks))"
    }
}
