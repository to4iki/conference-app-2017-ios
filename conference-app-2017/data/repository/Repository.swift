import RxSwift

protocol Repository {
    associatedtype Value
    func find() -> Single<Value>
    func findAll() -> Single<[Value]>
    func update()
}

extension Repository {
    func find() -> Single<Value> {
        fatalError("non implement")
    }

    func findAll() -> Single<[Value]> {
        fatalError("non implement")
    }

    func update() {
        fatalError("non implement")
    }
}

struct AnyRepository<T>: Repository {
    typealias Value = T
    private let _find: () -> Single<Value>
    private let _findAll: () -> Single<[Value]>
    private let _update: () -> Void

    init<U: Repository>(_ repository: U) where U.Value == T {
        self._find = repository.find
        self._findAll = repository.findAll
        self._update = repository.update
    }

    func find() -> Single<Value> {
        return _find()
    }

    func findAll() -> Single<[Value]> {
        return _findAll()
    }

    func update() {
        _update()
    }
}
