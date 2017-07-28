import OctavKit

extension Session {
    enum Tag {
        case duration(Int)
        case room(Conference.Track.Room)
        case level(Session.Level)

        var rawValue: String {
            switch self {
            case .duration(let value):
                return "\(value / 60)分"
            case .room(let value):
                return value.name
            case .level(let value):
                return value.rawValue
            }
        }
    }

    var tags: [Tag] {
        return [.duration(duration), .room(room), .level(materialLevel)]
    }
}

extension Session.Level {
    var rawValue: String {
        switch self {
        case .beginner:
            return "初級者"
        case .intermediate:
            return "中級者"
        case .advanced:
            return "上級者"
        }
    }
}
