import Foundation

extension DateFormatter {
    static let hour: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    static let day: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
    }()

    static let year: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter
    }()
}
