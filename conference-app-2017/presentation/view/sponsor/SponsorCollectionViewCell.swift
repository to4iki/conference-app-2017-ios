import UIKit
import Kingfisher
import OctavKit

final class SponsorCollectionViewCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var imageView: UIImageView!

    // TODO: fill whitespace
    static func size(by sponsor: Sponsor) -> CGSize {
        let space: Int = {
            let spaceWidth = 4
            let boarderWidth = 1
            let parentMargin = 8
            return spaceWidth + boarderWidth + parentMargin
        }()
        let width = Int(UIScreen.main.bounds.width / CGFloat(sponsor.tier.countPerRow)) - space
        return CGSize(width: width, height: width)
    }

    func setup(sponsor: Sponsor) {
        imageView.kf.setImage(with: sponsor.logoURL)
    }
}
