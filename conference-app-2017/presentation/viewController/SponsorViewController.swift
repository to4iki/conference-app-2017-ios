import UIKit
import SafariServices
import OctavKit

final class SponsorViewController: UIViewController {
    @IBOutlet fileprivate weak var collectionView: UICollectionView!

    var sponsors: [Int: [Sponsor]]!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNoTitleBackButton()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension SponsorViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sponsor.Group.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sponsors[section]!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(with: SponsorCollectionViewCell.self, for: indexPath).then {
            $0.setup(sponsor: sponsors[indexPath.section]![indexPath.row])
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SponsorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sponsor = sponsors[indexPath.section]![indexPath.row]
        let safariViewController = SFSafariViewController(url: sponsor.linkURL)
        present(safariViewController, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return SponsorCollectionViewCell.size(by: sponsors[indexPath.section]![indexPath.row])
    }
}
