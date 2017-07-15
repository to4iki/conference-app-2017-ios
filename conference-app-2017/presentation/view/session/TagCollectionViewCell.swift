import UIKit
import Then

final class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var nameLabel: UILabel!

    static func cellSize(by name: String) -> CGSize {
        let label = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 10)
            $0.text = name
        }
        let maxSize = CGSize(width: Int.max, height: Int.max)
        return CGSize(width: label.sizeThatFits(maxSize).width + 8, height: 22)
    }

    func setup(name: String) {
        nameLabel.text = name
    }
}
