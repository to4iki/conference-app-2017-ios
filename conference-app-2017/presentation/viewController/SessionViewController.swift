import UIKit

final class SessionViewController: UIViewController {

    var text: String = ""

    static func instantiate(text: String) -> SessionViewController {
        let viewController = SessionViewController.instantiate(withStoryboard: "Session")
        viewController.text = text
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("cell: \(text)")
    }
}
