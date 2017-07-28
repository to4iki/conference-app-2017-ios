import OctavKit

struct SponsorTranslater: Translator {
    static func translate(_ input: Conference) -> [Int: [Sponsor]] {
        return input.sponsors.groping()
    }
}

private extension Sequence where Iterator.Element == Sponsor {
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
