import UIKit

final class ReloadableViewController: UIViewController {
    @IBOutlet fileprivate weak var indicatorView: UIActivityIndicatorView!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        animateIndicatorView()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ReloadableViewController.refreshNotification(_:)),
            name: NSNotification.Name("test"),
            object: nil
        )
    }

    func refreshNotification(_ notification: Notification) {
        animateIndicatorView()
    }
}

extension ReloadableViewController {
    @IBAction func didTapRefreshButton(_ sender: UIBarButtonItem) {
        log.debug(#function)
    }
}

extension ReloadableViewController {
    fileprivate func animateIndicatorView() {
        if OnMemoryStorage.shared.timetables.isEmpty {
            indicatorView.startAnimating()
            indicatorView.isHidden = false
        } else {
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
        }
    }
}
