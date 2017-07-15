import Foundation
import OctavKit
import Himotoki

// TODO: deleted
struct DummyData {
    static let shared = DummyData()
    private init() {}

    let sessions: [Session] = DummyDataFactory.sessions()
    let conference: Conference = DummyDataFactory.conference()
}


private struct DummyDataFactory {
    private static let sessionsJsonPath = Bundle.main.path(forResource: "sessions", ofType:"json")!
    private static let conferenceJsonPath = Bundle.main.path(forResource: "conference", ofType:"json")!

    static func sessions() -> [Session] {
        let handle = FileHandle(forReadingAtPath: sessionsJsonPath)
        guard let data = handle?.readDataToEndOfFile() else { fatalError("load error") }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return try decodeArray(json)
        } catch {
            fatalError("error: \(error.localizedDescription)")
        }
    }

    static func conference() -> Conference {
        let handle = FileHandle(forReadingAtPath: conferenceJsonPath)
        guard let data = handle?.readDataToEndOfFile() else { fatalError("load error") }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return try Conference.decodeValue(json)
        } catch {
            fatalError("error: \(error.localizedDescription)")
        }
    }
}
