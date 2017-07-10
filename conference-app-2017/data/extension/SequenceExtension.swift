import Foundation
import OctavKit

extension Sequence where Iterator.Element == Session {
    func groping() -> [Date: [Iterator.Element]] {
        var result: [Date: [Iterator.Element]] = [:]
        for element in self {
            if result[element.startsOn.startOfDay] == nil {
                result[element.startsOn.startOfDay] = [element]
            } else {
                result[element.startsOn.startOfDay]!.append(element)
            }
        }
        return result
    }

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
