import UIKit
import OctavKit

final class VenueViewController: UIViewController {
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
