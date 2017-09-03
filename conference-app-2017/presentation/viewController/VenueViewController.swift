import UIKit
import MapKit
import OctavKit

final class VenueViewController: UIViewController {
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var urlTextView: UITextView!
    @IBOutlet fileprivate weak var addressTextView: UITextView!
    @IBOutlet fileprivate weak var mapView: MKMapView!

    fileprivate var venue: Conference.Venue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension VenueViewController {
    static func instantiate() -> VenueViewController {
        return Storyboard.venue.instantiate(type: VenueViewController.self)
    }
}
