import UIKit
import Kingfisher
import OctavKit
import Then

final class SessionViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startToEndLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var abstractTextView: UITextView!

    fileprivate var session: Session!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup(session: session)
    }
}

extension SessionViewController {
    static func instantiate(session: Session) -> SessionViewController {
        return SessionViewController.instantiate(withStoryboard: "Session").then {
            $0.session = session
        }
    }
}

extension SessionViewController {
    fileprivate func setup(session: Session) {
        titleLabel.text = session.title
        startToEndLabel.text = "\(DateFormatter.year.string(from: session.startsOn))"
        avatarImageView.kf.setImage(with: session.speaker.avatarURL)
        nicknameLabel.text = session.speaker.nickname
        abstractTextView.text = session.abstract
    }
}
