import Result
import OctavKit

struct SponsorService {
    private let conferenceRepository = ConferenceRespository()

    static let shared = SponsorService()
    private init() {}

    func read(completion: @escaping (Result<[Sponsor], RepositoryError>) -> Void) {
        conferenceRepository.read { result in
            switch result {
            case .success(let conference):
                completion(.success(conference.sponsors))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
