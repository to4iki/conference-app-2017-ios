import UIKit
import OctavKit
import SpreadsheetView
import SwiftDate
import XLPagerTabStrip

final class TimetableViewController: UIViewController {
    @IBOutlet fileprivate weak var spreadsheetView: SpreadsheetView!

    fileprivate(set) var timetable: Timetable!
    fileprivate lazy var startDate: Date = self.timetable.startToEnd.start
    fileprivate lazy var endDate: Date = self.timetable.startToEnd.end
    var holder: [IndexPath: Session] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self
        spreadsheetView.registerNib(type: SessionCell.self)
        spreadsheetView.register(types: [BlankCell.self, RoomTitleCell.self, DateTitleCell.self])
    }
}

extension TimetableViewController {
    static func instantiate(timetable: Timetable) -> TimetableViewController {
        return instantiate(withStoryboard: "Timetable").then {
            $0.timetable = timetable
        }
    }
}

// MARK: - IndicatorInfoProvider
extension TimetableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        let title = "\(timetable.date.month)/\(timetable.date.day)"
        return IndicatorInfo(title: title)
    }
}

// MARK: - SpreadsheetViewDataSource
extension TimetableViewController: SpreadsheetViewDataSource {
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return timetable.tracks.count + CellSetting.Header.numberOfColumns
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return (timetable.duration / DateTitleCell.IntervalMinutes) + CellSetting.Header.numberOfRows
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return CellSetting.Width(for: column).rawValue
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return CellSetting.Height(for: row).rawValue
    }

    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return CellSetting.Header.numberOfColumns
    }

    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return CellSetting.Header.numberOfRows
    }

    func mergedCells(in spreadsheetView: SpreadsheetView) -> [CellRange] {
        var mergedCells: [CellRange] = []
        for (index, track) in timetable.tracks.enumerated() {
            let columnIndex = index + 1

            var rowIndex = 0

            for i in (0..<track.sessions.count) {
                if i == 0 {
                    let blankFrame = Int(track.sessions[i].startsOn - startDate) / DateTitleCell.IntervalMinutes
                    if blankFrame != 0 {
                        let blankCellRange = CellRange(
                            from: (row: rowIndex + 1, column: columnIndex),
                            to: (row: rowIndex + blankFrame, column: columnIndex)
                        )
                        rowIndex += blankFrame
                        mergedCells.append(blankCellRange)
                    }
                }

                let frame = Int(track.sessions[i].duration) / DateTitleCell.IntervalMinutes
                let cellRange = CellRange(
                    from: (row: rowIndex + 1, column: columnIndex),
                    to: (row: rowIndex + frame, column: columnIndex)
                )
                rowIndex += frame
                mergedCells.append(cellRange)
                holder[IndexPath(row: cellRange.from.row, column: cellRange.from.column)] = track.sessions[i]

                var nextDate: Date!
                if i == track.sessions.count - 1 {
                    nextDate = endDate // TODO: timetable end date
                } else {
                    nextDate = track.sessions[i + 1].startsOn
                }

                let blankFrame = Int(nextDate - track.sessions[i].endsOn) / DateTitleCell.IntervalMinutes
                guard blankFrame != 0 else { continue }

                let blankCellRange = CellRange(
                    from: (row: rowIndex + 1, column: columnIndex),
                    to: (row: rowIndex + blankFrame, column: columnIndex)
                )
                rowIndex += blankFrame
                mergedCells.append(blankCellRange)
            }
        }

        return mergedCells
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        switch (indexPath.column == CellSetting.Header.columnIndex, indexPath.row == CellSetting.Header.rowIndex) {
        case (true, true):
            return nil
        case (true, false):
            let elapsedSecond = (DateTitleCell.IntervalMinutes * (indexPath.row - CellSetting.Header.numberOfRows)).second
            let date = startDate + elapsedSecond
            return spreadsheetView.dequeueReusableCell(with: DateTitleCell.self, for: indexPath).then {
                $0.setup(date: date)
            }
        case (false, true):
            let track = timetable.tracks[indexPath.column - CellSetting.Header.numberOfColumns]
            return spreadsheetView.dequeueReusableCell(with: RoomTitleCell.self, for: indexPath).then {
                $0.setup(room: track.room)
            }
        case (false, false):
            if let session = holder[indexPath] {
                return spreadsheetView.dequeueReusableCell(with: SessionCell.self, for: indexPath).then {
                    $0.setup(session: session)
                }
            } else {
                return spreadsheetView.dequeueReusableCell(with: BlankCell.self, for: indexPath)
            }
        }
    }
}

// MARK: - SpreadsheetViewDelegate
extension TimetableViewController: SpreadsheetViewDelegate {
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        guard let session = holder[indexPath] else { return }
        log.debug("Selected: (session: \(session))")
    }
}
