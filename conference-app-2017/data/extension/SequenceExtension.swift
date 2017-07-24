import Foundation
import OctavKit

extension Sequence where Iterator.Element == Session {
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

extension Sequence where Iterator.Element == Sponsor {
    func groping() -> [Int: [Iterator.Element]] {
        var result: [Int: [Iterator.Element]] = [:]
        for element in self {
            let key = Sponsor.Group(rawValue: element.groupName)!.rawValue
            if result[key] == nil {
                result[key] = [element]
            } else {
                result[key]!.append(element)
            }
        }
        return result
    }
}
