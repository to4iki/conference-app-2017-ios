import UIKit

extension UIViewController {
    func setNoTitleBackButton() {
        guard let navigationController = navigationController else { return }
        guard let navigationBarTopItem = navigationController.navigationBar.topItem else { return }
        navigationBarTopItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
