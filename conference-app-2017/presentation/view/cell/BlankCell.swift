import UIKit
import SpreadsheetView

final class BlankCell: Cell {
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
        gridlines.top = .solid(width: 0.5, color: .black)
        gridlines.bottom = gridlines.top
        gridlines.right = .solid(width: 0.5, color: .black)
        gridlines.left = gridlines.right
    }
}
