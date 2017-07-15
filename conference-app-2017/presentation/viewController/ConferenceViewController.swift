import UIKit
import XLPagerTabStrip

final class ConferenceViewController: ButtonBarPagerTabStripViewController {
    // TODO: fetch real datas
    /// dummy
    private let timetables: [Timetable] = TimetableFactory.create(
        conference: DummyData.shared.conference,
        sessions: DummyData.shared.sessions
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.isScrollEnabled = false
        setupNavigationItemStyle()
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return timetables.map(TimetableViewController.instantiate)
    }
}

extension ConferenceViewController {
    fileprivate func setupNavigationItemStyle() {
        buttonBarView.backgroundColor = .white
        buttonBarView.selectedBar.backgroundColor = UIColor.Builderscon.themeBlue
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemTitleColor = .black
    }
}
