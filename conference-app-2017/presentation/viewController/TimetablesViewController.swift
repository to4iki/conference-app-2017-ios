import UIKit
import XLPagerTabStrip

final class TimetablesViewController: ButtonBarPagerTabStripViewController {
    // TODO: fetch real datas
    /// dummy
    private let conference = DummyDataFactory.conference()
    private let sessions = DummyDataFactory.sessions()
    private lazy var timetables: [Timetable] = TimetableFactory.create(
        conference: self.conference,
        sessions: self.sessions
    )

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
