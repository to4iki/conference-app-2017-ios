import UIKit
import SpreadsheetView
import OctavKit

final class RoomTitleCell: Cell {
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        gridlines.top = .solid(width: 1, color: .black)
        gridlines.bottom = gridlines.top
        gridlines.right = .solid(width: 1, color: .black)
        gridlines.left = gridlines.right
        addSubview(label)
    }
}

extension RoomTitleCell {
    func setup(room: Conference.Track.Room) {
        label.text = room.name
    }
}
