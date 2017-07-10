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
}
