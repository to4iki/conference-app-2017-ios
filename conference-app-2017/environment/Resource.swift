import Foundation

struct Resource {
    enum JSON: String {
        case conference
        case sessions

        var filePath: String {
            return Bundle.main.path(forResource: "resource/\(rawValue)", ofType: "json")!
        }
    }
}
