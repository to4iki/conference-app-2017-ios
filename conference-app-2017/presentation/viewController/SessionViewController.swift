import UIKit
import Then

final class SessionViewController: UIViewController {

    var text: String = ""

    static func instantiate(text: String) -> SessionViewController {
        return SessionViewController.instantiate(withStoryboard: "Session").then {
            $0.text = text
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("cell: \(text)")
    }
}
