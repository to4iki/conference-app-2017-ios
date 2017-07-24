import Foundation

extension DateFormatter {
    static let hour: DateFormatter = {
        var formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "JST")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    static let day: DateFormatter = {
        var formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "JST")
        formatter.dateFormat = "MM/dd"
        return formatter
    }()

    static let year: DateFormatter = {
        var formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "JST")
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter
    }()
}
