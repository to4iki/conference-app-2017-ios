import Foundation

extension URL {
    var secure: URL {
        let replaced = Regex("https?").replace(input: absoluteString, after: "https")
        return URL(string: replaced)!
    }
}
