import SafariServices

extension UIViewController {
    func presentSafariViewController(url: URL, animated flag: Bool, completion: (() -> Void)? = nil) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        UIApplication.shared.statusBarStyle = .default
        present(safariViewController, animated: flag, completion: completion)
    }
}

// MARK: - SFSafariViewControllerDelegate
extension UIViewController: SFSafariViewControllerDelegate {
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
