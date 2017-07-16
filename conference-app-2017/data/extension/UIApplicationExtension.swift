
import UIKit

extension UIApplication {
    var topViewController: UIViewController? {
        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        while case .some = topViewController.presentedViewController {
            topViewController = topViewController.presentedViewController!
        }
        return topViewController
    }
}
