import Foundation
import OctavKit
import SwiftDate

struct Track {
    let name: String
    let sessions: [Session]

    var duration: TimeInterval {
        guard let min = sessions.min() else { return 0 }
        guard let max = sessions.max() else { return 0 }
        return max.endsOn - min.startsOn
    }

    init?(track: Conference.Track, grouped: [Id<Conference.Track.Room>: [Session]]) {
        guard let sessions = grouped[track.roomId] else { return nil }
        self.name = track.name
        self.sessions = sessions
    }
}

// MARK: - CustomStringConvertible
extension Track: CustomStringConvertible {
    var description: String {
        return "Track(name: \(name), sessions: \(sessions))"
    }
}
