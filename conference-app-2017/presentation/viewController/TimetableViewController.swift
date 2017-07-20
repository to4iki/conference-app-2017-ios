import UIKit
import OctavKit
import SpreadsheetView
import SwiftDate
import XLPagerTabStrip

final class TimetableViewController: UIViewController {
    @IBOutlet fileprivate weak var spreadsheetView: SpreadsheetView!

    fileprivate(set) var day: ConferenceDay!
    fileprivate(set) var tracks: [Track] = []
    fileprivate(set) var schedule: Conference.Schedule!
    fileprivate(set) var sessionHolder: [IndexPath: Session] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self
        spreadsheetView.registerNib(types: [SessionCell.self, ShortSessionCell.self])
        spreadsheetView.register(types: [BlankCell.self, TrackTitleCell.self, DateTitleCell.self])
        setupTimetable()
    }

    private func setupTimetable() {
        TimetableService.shared.read { [weak self] result in
            guard let strongSelf = self else { return }
            if case .success(let value) = result {
                let timetable = value[strongSelf.day.rawValue]
                strongSelf.tracks = timetable.tracks
                strongSelf.schedule = timetable.schedule
                DispatchQueue.main.async {
                    strongSelf.spreadsheetView.reloadData()
                }
            }
        }
    }
}

extension TimetableViewController {
    static func instantiate(day: ConferenceDay) -> TimetableViewController {
        return instantiate(withStoryboard: "Conference").then { $0.day = day }
    }
}

// MARK: - IndicatorInfoProvider
extension TimetableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: day.rawDate)
    }
}

// MARK: - SpreadsheetViewDataSource
extension TimetableViewController: SpreadsheetViewDataSource {
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return tracks.count + CellSetting.Header.numberOfColumns
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        guard let schedule = schedule else { return 0 }
        return (Int(schedule.duration) / DateTitleCell.IntervalMinutes) + CellSetting.Header.numberOfRows
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if column != CellSetting.Header.columnIndex && tracks.count == CellSetting.requiredAdjustmentTrackCount {
            return UIScreen.main.bounds.width - CellSetting.Width.header.rawValue
        } else {
            return CellSetting.Width(for: column).rawValue
        }
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return CellSetting.Height(for: row).rawValue
    }

    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        guard !tracks.isEmpty else { return 0 }
        return CellSetting.Header.numberOfColumns
    }

    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        guard !tracks.isEmpty else { return 0 }
        return CellSetting.Header.numberOfRows
    }

    // TODO: refactoring
    func mergedCells(in spreadsheetView: SpreadsheetView) -> [CellRange] {
        var mergedCells: [CellRange] = []
        for (index, track) in tracks.enumerated() {
            let columnIndex = index + 1
            var rowIndex = 0
            for i in (0..<track.sessions.count) {
                if i == 0 {
                    let blankFrame = Int(track.sessions[i].startsOn - schedule.open) / DateTitleCell.IntervalMinutes
                    if blankFrame != 0 {
                        let blankCellRange = CellRange(
                            from: (row: rowIndex + 1, column: columnIndex),
                            to: (row: rowIndex + blankFrame, column: columnIndex)
                        )
                        rowIndex += blankFrame
                        mergedCells.append(blankCellRange)
                    }
                }

                let frame = track.sessions[i].duration / DateTitleCell.IntervalMinutes
                let cellRange = CellRange(
                    from: (row: rowIndex + 1, column: columnIndex),
                    to: (row: rowIndex + frame, column: columnIndex)
                )
                rowIndex += frame
                mergedCells.append(cellRange)
                sessionHolder[IndexPath(row: cellRange.from.row, column: cellRange.from.column)] = track.sessions[i]

                var nextDate: Date!
                if i == track.sessions.count - 1 {
                    nextDate = schedule.close
                } else {
                    nextDate = track.sessions[i + 1].startsOn
                }

                let blankFrame = Int(nextDate - track.sessions[i].endsOn) / DateTitleCell.IntervalMinutes
                if blankFrame != 0 {
                    let blankCellRange = CellRange(
                        from: (row: rowIndex + 1, column: columnIndex),
                        to: (row: rowIndex + blankFrame, column: columnIndex)
                    )
                    rowIndex += blankFrame
                    mergedCells.append(blankCellRange)
                }
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
            let date = schedule.open + elapsedSecond
            return spreadsheetView.dequeueReusableCell(with: DateTitleCell.self, for: indexPath).then {
                $0.setup(date: date)
            }
        case (false, true):
            let track = tracks[indexPath.column - CellSetting.Header.numberOfColumns]
            return spreadsheetView.dequeueReusableCell(with: TrackTitleCell.self, for: indexPath).then {
                $0.setup(name: track.name)
            }
        case (false, false):
            switch sessionHolder[indexPath] {
            case .some(let session) where session.duration == ShortSessionCell.requiredDuration:
                return spreadsheetView.dequeueReusableCell(with: ShortSessionCell.self, for: indexPath).then {
                    $0.setup(session: session)
                }
            case .some(let session):
                return spreadsheetView.dequeueReusableCell(with: SessionCell.self, for: indexPath).then {
                    $0.setup(session: session)
                }
            case .none:
                return spreadsheetView.dequeueReusableCell(with: BlankCell.self, for: indexPath)
            }
        }
    }
}

// MARK: - SpreadsheetViewDelegate
extension TimetableViewController: SpreadsheetViewDelegate {
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        guard let session = sessionHolder[indexPath] else { return }
        let viewController = SessionViewController.instantiate(session: session)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
