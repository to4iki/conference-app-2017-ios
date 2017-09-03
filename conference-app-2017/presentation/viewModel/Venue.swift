import Foundation
import MapKit

struct Venue {
    let name: String
    let url: URL
    let address: String
    let location: Location

    var coordinateRegion: MKCoordinateRegion {
        return MKCoordinateRegion(center: location.coordinate2D, span: location.coordinateSpan)
    }

    var pointAnnotation: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate2D
        annotation.title = name
        return annotation
    }
}

extension Venue {
    struct Location {
        let latitude: Double
        let longitude: Double

        var coordinate2D: CLLocationCoordinate2D {
            return CLLocationCoordinate2DMake(latitude, longitude)
        }

        var coordinateSpan: MKCoordinateSpan {
            return MKCoordinateSpanMake(0.01, 0.01)
        }
    }
}
