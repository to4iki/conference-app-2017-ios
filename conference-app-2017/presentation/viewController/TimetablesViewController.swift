import UIKit
import XLPagerTabStrip

final class TimetablesViewController: ButtonBarPagerTabStripViewController {
    /// dummy
    private let navigationTitles = ["8/3", "8/4", "8/5"]

    override func viewDidLoad() {
        setupNavigationItemStyle()
        super.viewDidLoad()
        containerView.isScrollEnabled = false
        buttonBarView.removeFromSuperview()
        navigationController?.navigationBar.addSubview(buttonBarView)
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return navigationTitles.map {
            TimetableViewController.instantiate(navigationTitle: $0)
        }
    }
}

extension TimetablesViewController {

    fileprivate func setupNavigationItemStyle() {
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.buttonBarItemTitleColor = .black
        settings.style.selectedBarBackgroundColor = UIColor.Builderscon.themeBlue
    }
}
