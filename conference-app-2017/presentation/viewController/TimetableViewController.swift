import UIKit
import SpreadsheetView
import XLPagerTabStrip

final class TimetableViewController: UIViewController {

    @IBOutlet weak var spreadsheetView: SpreadsheetView!
    /// dummy
    fileprivate(set) var navigationTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spreadsheetView.dataSource = self
    }
}

extension TimetableViewController {

    static func instantiate(navigationTitle: String) -> TimetableViewController {
        return instantiate(withStoryboard: "Timetable").then {
            $0.navigationTitle = navigationTitle
        }
    }
}

// MARK: - IndicatorInfoProvider
extension TimetableViewController: IndicatorInfoProvider {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: navigationTitle)
    }
}

// MARK: - SpreadsheetViewDataSource
extension TimetableViewController: SpreadsheetViewDataSource {

    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 6
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 10
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 100
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 100
    }
}
