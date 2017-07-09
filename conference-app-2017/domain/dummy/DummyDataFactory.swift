import Foundation
import OctavKit
import Himotoki

// TODO: deleted
struct DummyDataFactory {
    private static let rawSessions = Bundle.main.path(forResource: "sessions", ofType:"json")!

    static func sessions() -> [Session] {
        let handle = FileHandle(forReadingAtPath: rawSessions)
        guard let data = handle?.readDataToEndOfFile() else { fatalError("load error") }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return try decodeArray(json)
        } catch {
            fatalError("error: \(error.localizedDescription)")
        }
    }
}
