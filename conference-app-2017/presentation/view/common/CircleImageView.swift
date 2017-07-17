import UIKit

// TODO: override drawRect used UIBezierPath
final class CircleImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = min(frame.width / 2, frame.height / 2)
        clipsToBounds = true
    }
}
