import OctavKit
import RxSwift

enum RepositoryError: Error {
    case find(Error)
}

struct SessionRepository {
    private let localDataStore: SessionLocalDataStore
    private let remoteDataStore: SessionRemoteDataStore
    private let disposeBag = DisposeBag()

    init(
        localDataStore: SessionLocalDataStore = SessionLocalDataStore.shared,
        remoteDataStore: SessionRemoteDataStore = SessionRemoteDataStore.shared)
    {
        self.localDataStore = localDataStore
        self.remoteDataStore = remoteDataStore
    }

    func findAll() -> Single<[Session]> {
        return localDataStore.findAll().catchError { _ in
            self.remoteDataStore.findAll().map { sessions in
                self.storeToLocalDataStore(sessions)
                return sessions
            }
        }
    }

    func update() {
        remoteDataStore.findAll().subscribe { observer in
            switch observer {
            case .success(let sessions):
                self.storeToLocalDataStore(sessions)
            case .error(let error):
                log.error("remoteDataStore error: \(error.localizedDescription)")
            }
        }
        .disposed(by: disposeBag)
    }

    private func storeToLocalDataStore(_ value: [Session]) {
        self.localDataStore.store(value).subscribe(
            onCompleted: { _ in log.debug("localDataStore store completed") },
            onError: { error in log.error("localDataStore error: \(error.localizedDescription)") }
        ).disposed(by: self.disposeBag)
    }
}
