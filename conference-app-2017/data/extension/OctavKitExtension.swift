import Foundation
import OctavKit
import SwiftDate

extension Room: Hashable {
    public var hashValue: Int {
        return id.hashValue
    }
}

extension Session {
    var endsOn: Date {
        return startsOn + Int(duration).second
    }
}
