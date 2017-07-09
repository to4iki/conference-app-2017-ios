import Foundation
import OctavKit
import SwiftDate

extension Sequence where Iterator.Element == Session {
    func groping() -> [Timetable] {
        var result: [Date: [Iterator.Element]] = [:]
        for element in self {
            if result[element.startsOn.startOfDay] == nil {
                result[element.startsOn.startOfDay] = [element]
            } else {
                result[element.startsOn.startOfDay]!.append(element)
            }
        }
        return result.map { (key: Date, value: [Iterator.Element]) -> Timetable in
            Timetable(date: key, tracks: value.groping())
        }
    }

    private func groping() -> [Track] {
        var result: [Room: [Iterator.Element]] = [:]
        for element in self {
            if result[element.room] == nil {
                result[element.room] = [element]
            } else {
                result[element.room]!.append(element)
            }
        }
        return result.map(Track.init)
    }
}
