import UIKit

enum Storyboard: String {
    case conference
    case session

    func instantiate<T: UIViewController>(type: T.Type) -> T {
        let storyboard = UIStoryboard(name: rawValue.capitalized, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: T.className) as! T
    }
}
