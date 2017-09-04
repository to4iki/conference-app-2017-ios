import UIKit

final class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AboutUsViewController {
    static func instantiate() -> AboutUsViewController {
        return Storyboard.aboutUs.instantiate(type: AboutUsViewController.self)
    }
}
