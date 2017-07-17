import UIKit
import Kingfisher
import OctavKit
import SpreadsheetView

protocol SessionCellLayoutable {
    weak var imageView: UIImageView! { get }
    weak var titleLabel: UILabel! { get }
    func setup(session: Session)
}

extension SessionCellLayoutable {
    func setup(session: Session) {
        imageView.kf.setImage(with: session.speaker.avatarURL)
        titleLabel.text = session.title
    }
}

final class ShortSessionCell: Cell, SessionCellLayoutable {
    static let requiredDuration = 600
    @IBOutlet fileprivate(set) weak var imageView: UIImageView!
    @IBOutlet fileprivate(set) weak var titleLabel: UILabel!
}

final class SessionCell: Cell, SessionCellLayoutable {
    @IBOutlet fileprivate(set) weak var imageView: UIImageView!
    @IBOutlet fileprivate(set) weak var titleLabel: UILabel!
}
