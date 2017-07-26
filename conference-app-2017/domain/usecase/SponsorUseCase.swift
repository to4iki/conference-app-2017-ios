import Result
import OctavKit

struct SponsorUseCase {
    private let conferenceRepository: ConferenceRespository

    init(conferenceRepository: ConferenceRespository = ConferenceRespository()) {
        self.conferenceRepository = conferenceRepository
    }

    func findAll(completion: @escaping (Result<[Int: [Sponsor]], RepositoryError>) -> Void) {
        conferenceRepository.find { result in
            switch result {
            case .success(let conference):
                completion(.success(SponsorTranslater.translate(conference)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
