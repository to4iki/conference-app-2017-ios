import UIKit
import OctavKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupUINavigation()
        setupOctavKit()
        return true
    }
}

extension AppDelegate {
    fileprivate func setupUINavigation() {
        UINavigationBar.appearance().barTintColor = UIColor.Builderscon.themeRed
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    fileprivate func setupOctavKit() {
        OctavKit.setup(conferenceId: Config.conferenceIdentifier)
        OctavKit.setLocale(Locale.current)
        warmup()
    }

    private func warmup() {
        ConferenceRespository.warmup()
        SessionRepository.warmup()
    }
}
