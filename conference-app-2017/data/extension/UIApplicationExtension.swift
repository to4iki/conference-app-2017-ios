import UIKit

extension UIApplication {
    var topViewController: UIViewController? {
        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        while case .some = topViewController.presentedViewController {
            topViewController = topViewController.presentedViewController!
        }
        return topViewController
    }

    func findViewController<T: UIViewController>(_ type: T.Type) -> T? {
        func go(childViewControllers: [UIViewController]) -> T? {
            if let viewController: T = childViewControllers.convert(to: T.self).first {
                return viewController
            } else {
                if childViewControllers.nonEmpty {
                    let grandsonViewControllers = childViewControllers.flatMap({ $0.childViewControllers })
                    return go(childViewControllers: grandsonViewControllers)
                } else {
                    return nil
                }
            }
        }

        guard let topViewController = topViewController else { return nil }
        if let viewController = topViewController as? T {
            return viewController
        } else {
            return go(childViewControllers: topViewController.childViewControllers)
        }
    }
}
