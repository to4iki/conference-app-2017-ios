import UIKit
import SpreadsheetView

final class TrackTitleCell: Cell {
    fileprivate let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        gridlines.top = .solid(width: 1, color: .black)
        gridlines.bottom = gridlines.top
        gridlines.right = .solid(width: 1, color: .black)
        gridlines.left = gridlines.right
        addSubview(label)
    }
}

extension TrackTitleCell {
    func setup(name: String) {
        label.text = name
    }
}
