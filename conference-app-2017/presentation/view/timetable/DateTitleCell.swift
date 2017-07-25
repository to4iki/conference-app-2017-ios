import UIKit
import SpreadsheetView
import OctavKit

final class DateTitleCell: Cell {
    fileprivate let label = UILabel()

    static let IntervalMinutes: Int = 5 * 60

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.Builderscon.lightGray
        label.textColor = .black
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        gridlines.top = .solid(width: 1, color: .black)
        gridlines.bottom = gridlines.top
        gridlines.right = .solid(width: 1, color: .black)
        gridlines.left = gridlines.right
        addSubview(label)
    }
}

extension DateTitleCell {
    func setup(date: Date) {
        label.text = date.string(format: .custom("HH:mm"))
    }
}
