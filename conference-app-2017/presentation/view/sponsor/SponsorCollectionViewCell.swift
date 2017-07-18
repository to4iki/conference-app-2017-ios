import UIKit
import Kingfisher
import OctavKit

final class SponsorCollectionViewCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    static func size(by sponsor: Sponsor) -> CGSize {
        let margin = 8
        let viewWidth = Int(UIScreen.main.bounds.width) - ((sponsor.tier.countPerRow) + 1) * margin
        let cellWidth = viewWidth / sponsor.tier.countPerRow
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func setup(sponsor: Sponsor) {
        imageView.kf.setImage(with: sponsor.logoURL)
    }
}
