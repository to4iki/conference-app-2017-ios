import OctavKit

struct TimetableTranslater: Translator {
    static func translate(_ input: (conference: Conference, sessions: [Session])) -> [Timetable] {
        return input.conference.schedules.map { (schedule: Conference.Schedule) in
            let predicate: (Session) -> Bool = { $0.startsOn.startOfDay == schedule.open.startOfDay }
            let groupedByStartOfDay = input.sessions.lazy.filter(predicate).groping()
            let tracks = input.conference.tracks.reduce([]) { (acc: [Track], value: Conference.Track) -> [Track] in
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

private extension Sequence where Iterator.Element == Session {
    func groping() -> [Id<Conference.Track.Room>: [Iterator.Element]] {
        var result: [Id<Conference.Track.Room>: [Iterator.Element]] = [:]
        for element in self {
            if result[element.room.id] == nil {
                result[element.room.id] = [element]
            } else {
                result[element.room.id]!.append(element)
            }
        }
        return result
    }
}
