import UIKit

struct ApplicationShortcut {
    private enum ShortcutType: String {
        case qrCodeReader = "QRCodeReader"
    }

    private static var tabBarController: UITabBarController {
        return UIApplication.shared.findViewController(UITabBarController.self)!
    }

    static func handleShortcutItem(with item: UIApplicationShortcutItem) -> Bool {
        let rawShortcutType = item.type.components(separatedBy: ".").last!
        switch ShortcutType(rawValue: rawShortcutType) {
        case .some(.qrCodeReader):
            let tabBarController = self.tabBarController
            tabBarController.selectedIndex = 1
            if
                let navigationController = tabBarController.selectedViewController,
                let informationViewController = navigationController.childViewControllers.convert(to: InformationViewController.self).first
            {
                informationViewController.presentQRCodeReader(animated: false, completion: nil)
                return true
            } else {
                return false
            }
        case .none:
            return false
        }
    }
}
