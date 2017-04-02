import Foundation

extension NSObject {

    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}
