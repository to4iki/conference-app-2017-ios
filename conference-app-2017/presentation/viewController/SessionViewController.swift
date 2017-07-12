import UIKit
import Kingfisher
import MarkdownView
import OctavKit
import Then

final class SessionViewController: UIViewController {
    @IBOutlet fileprivate weak var contentView: UIView!
    @IBOutlet fileprivate weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var startToEndLabel: UILabel!
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet fileprivate weak var nicknameLabel: UILabel!
    @IBOutlet fileprivate weak var abstractMarkdownView: MarkdownView!
    @IBOutlet fileprivate weak var abstractMarkdownViewHeight: NSLayoutConstraint!

    fileprivate var session: Session!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout(session: session)
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
    fileprivate func setupLayout(session: Session) {
        hideLayout()
        titleLabel.text = session.title
        startToEndLabel.text = "\(DateFormatter.year.string(from: session.startsOn))"
        avatarImageView.kf.setImage(with: session.speaker.avatarURL)
        nicknameLabel.text = session.speaker.nickname
        abstractMarkdownView.load(markdown: session.abstract)
        abstractMarkdownView.isScrollEnabled = false
        abstractMarkdownView.onRendered = { [weak self] (height: CGFloat) in
            guard let strongSelf = self else { return }
            strongSelf.showLayout()
            strongSelf.abstractMarkdownViewHeight.constant = height
            strongSelf.view.setNeedsLayout()
        }
    }

    private func showLayout() {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        contentView.isHidden = false
    }

    private func hideLayout() {
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        contentView.isHidden = true
    }
}
