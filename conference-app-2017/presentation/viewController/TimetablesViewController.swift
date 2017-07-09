import UIKit
import XLPagerTabStrip

final class TimetablesViewController: ButtonBarPagerTabStripViewController {
    // TODO: fetch real datas
    /// dummy
    private let timetables = DummyDataFactory.sessions().groping()

    override func viewDidLoad() {
        setupNavigationItemStyle()
        super.viewDidLoad()
        containerView.isScrollEnabled = false
        buttonBarView.removeFromSuperview()
        navigationController?.navigationBar.addSubview(buttonBarView)
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return timetables.map(TimetableViewController.instantiate)
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
