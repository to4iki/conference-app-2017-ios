import UIKit

struct Alert {
    final class Builder {
        private let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        private weak var presentingViewController: UIViewController?

        init(presentingViewController: UIViewController? = UIApplication.shared.topViewController) {
            self.presentingViewController = presentingViewController
        }

        @discardableResult
        func set(title: String) -> Builder {
            actionSheetController.title = title
            return self
        }

        @discardableResult
        func set(message: String) -> Builder {
            actionSheetController.message = message
            return self
        }

        @discardableResult
        func set(action: UIAlertAction) -> Builder {
            actionSheetController.addAction(action)
            return self
        }

        func present(animated: Bool, completion: (() -> Void)?) {
            presentingViewController?.present(actionSheetController, animated: true, completion: completion)
        }
    }
}
