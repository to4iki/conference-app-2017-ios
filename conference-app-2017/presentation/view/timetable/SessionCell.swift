import UIKit
import Kingfisher
import OctavKit
import SpreadsheetView

final class SessionCell: Cell {
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension SessionCell {
    func setup(session: Session) {
        imageView.kf.setImage(with: session.speaker.avatarURL)
        titleLabel.text = session.title
    }
}
