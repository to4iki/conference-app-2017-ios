import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupUINavigation()
        return true
    }
}

extension AppDelegate {
    fileprivate func setupUINavigation() {
        UINavigationBar.appearance().barTintColor = UIColor.Builderscon.themeRed
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
}
