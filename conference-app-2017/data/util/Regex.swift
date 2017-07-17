import Foundation

struct Regex {
    private let internalExpression: NSRegularExpression
    private let pattern: String

    init(_ pattern: String) {
        self.pattern = pattern
        do {
            self.internalExpression = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        } catch let error as NSError {
            log.error(error.localizedDescription)
            self.internalExpression = NSRegularExpression()
        }
    }

    func isMatch(_ input: String) -> Bool {
        let matches = internalExpression.matches(in: input, options: [], range: NSRange(location: 0, length: input.characters.count))
        return matches.count > 0
    }

    func matches(_ input: String) -> [String]? {
        guard isMatch(input) else { return nil }
        let matches = internalExpression.matches(in: input, options: [], range: NSRange(location: 0, length: input.characters.count))
        return (0..<matches.count).reduce([]) { (acc: [String], n: Int) -> [String] in
            acc + [(input as NSString).substring(with: matches[n].range)]
        }
    }

    func replace(input: String, after: String) -> String {
        guard let matches = matches(input) else { return input }
        return (0..<matches.count).reduce(input) { (acc: String, n: Int) -> String in
            acc.replacingOccurrences(of: matches[n], with: after, options: [], range: nil)
        }
    }
}
