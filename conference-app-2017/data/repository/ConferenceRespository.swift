import OctavKit
import RxSwift

struct ConferenceRespository {
    private let localDataStore: ConferenceLocalDataStore
    private let remoteDataStore: ConferenceRemoteDataStore
    private let disposeBag = DisposeBag()

    init(
        localDataStore: ConferenceLocalDataStore = ConferenceLocalDataStore.shared,
        remoteDataStore: ConferenceRemoteDataStore = ConferenceRemoteDataStore.shared)
    {
        self.localDataStore = localDataStore
        self.remoteDataStore = remoteDataStore
    }

    func find() -> Single<Conference> {
        return localDataStore.find().catchError { _ in
            self.remoteDataStore.find().map { conference in
                self.storeToLocalDataStore(conference)
                return conference
            }
        }
    }

    func update() {
        remoteDataStore.find().subscribe { observer in
            switch observer {
            case .success(let conference):
                self.storeToLocalDataStore(conference)
            case .error(let error):
                log.error("remoteDataStore error: \(error.localizedDescription)")
            }
        }
        .disposed(by: disposeBag)
    }

    private func storeToLocalDataStore(_ value: Conference) {
        self.localDataStore.store(value).subscribe(
            onCompleted: { _ in log.debug("localDataStore store completed") },
            onError: { error in log.error("localDataStore error: \(error.localizedDescription)") }
        ).disposed(by: self.disposeBag)
    }
}
