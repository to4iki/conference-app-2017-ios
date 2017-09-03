import UIKit
import MapKit

final class VenueViewController: UIViewController {
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var urlTextView: UITextView!
    @IBOutlet fileprivate weak var addressTextView: UITextView!
    @IBOutlet fileprivate weak var mapView: MKMapView!

    fileprivate var venue: Venue!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNoTitleBackButton()
        setup()
    }
}

extension VenueViewController {
    static func instantiate(venue: Venue) -> VenueViewController {
        return Storyboard.venue.instantiate(type: VenueViewController.self).then {
            $0.venue = venue
        }
    }
}

extension VenueViewController {
    fileprivate func setup() {
        nameLabel.text = venue.name
        setupURLTextView()
        setupAddressTextView()
        setupMapView()
    }

    private func setupURLTextView() {
        urlTextView.text = venue.url.secure.absoluteString
        urlTextView.textContainerInset = .zero
        urlTextView.textContainer.lineFragmentPadding = 0
        urlTextView.delegate = self
    }

    private func setupAddressTextView() {
        addressTextView.text = venue.address
        addressTextView.textContainerInset = .zero
        addressTextView.textContainer.lineFragmentPadding = 0
    }

    private func setupMapView() {
        mapView.setRegion(venue.coordinateRegion, animated: true)
        mapView.addAnnotation(venue.pointAnnotation)
    }
}

// MARK: - UITextViewDelegate
extension VenueViewController: UITextViewDelegate {
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        presentSafariViewController(url: venue.url, animated: true)
        return false
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        presentSafariViewController(url: venue.url, animated: true)
        return false
    }
}
