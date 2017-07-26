import OctavKit

extension Sponsor {
    enum Group {
        case tier1
        case tier2
        case tier3

        var rawValue: Int {
            switch self {
            case .tier1:
                return 0
            case .tier2:
                return 1
            case .tier3:
                return 2
            }
        }

        var countPerRow: Int {
            switch self {
            case .tier1:
                return 2
            case .tier2:
                return 3
            case .tier3:
                return 4
            }
        }

        static var count: Int {
            return 3
        }

        init?(rawValue: String) {
            switch rawValue {
            case "tier-1":
                self = .tier1
            case "tier-2":
                self = .tier2
            case "tier-3":
                self = .tier3
            default:
                return nil
            }
        }
    }

    var tier: Group {
        return Group(rawValue: groupName)!
    }
}
