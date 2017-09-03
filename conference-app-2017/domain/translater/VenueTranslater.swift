import OctavKit

struct VenueTranslater: Translator {
    static func translate(_ input: Conference.Venue) -> Venue {
        return Venue(
            name: input.name,
            url: input.url,
            address: input.address,
            location: Venue.Location(
                latitude: input.location.latitude,
                longitude: input.location.longitude
            )
        )
    }
}
