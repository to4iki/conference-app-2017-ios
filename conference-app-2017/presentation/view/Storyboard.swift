import UIKit

enum Storyboard: String {
    case conference
    case session
    case sponsor
    case venue
    case floorMap
    case aboutUs

    func instantiate<T: UIViewController>(type: T.Type) -> T {
        let storyboard = UIStoryboard(name: rawValue.capitalizedFirst, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: T.className) as! T
    }
}
