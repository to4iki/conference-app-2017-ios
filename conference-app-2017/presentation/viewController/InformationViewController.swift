import UIKit

final class InformationViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension InformationViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "\(SponsorViewController.className)Segue" {
            let viewController = segue.destination as! SponsorViewController
            viewController.sponsors = DummyData.shared.conference.sponsors.groping()
        }
    }
}
