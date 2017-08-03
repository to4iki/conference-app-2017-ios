import UIKit
import SwiftDate
import XLPagerTabStrip

final class ConferenceViewController: ButtonBarPagerTabStripViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.isScrollEnabled = false
        setupNavigationItemStyle()
        if let conferenceDay = ConferenceDay(date: Date()) {
            moveToViewController(at: conferenceDay.rawValue, animated: false)
        }
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return ConferenceDay.cases.map(TimetableViewController.instantiate)
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

enum ConferenceDay: Int, EnumEnumerable {
    case first
    case second
    case third

    var rawDate: String {
        switch self {
        case .first:
            return "8/3"
        case .second:
            return "8/4"
        case .third:
            return "8/5"
        }
    }

    init?(date: Date) {
        switch date.string(format: .custom("MM/dd")) {
        case "08/03":
            self = .first
        case "08/04":
            self = .second
        case "08/05":
            self = .third
        default:
            return nil
        }
    }
}
