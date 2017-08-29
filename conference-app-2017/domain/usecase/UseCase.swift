import RxSwift

protocol UseCase {
    associatedtype Value
}

protocol ReadUseCase: UseCase {
    func execute() -> Single<Value>
}

struct AnyReadUseCase<T>: ReadUseCase {
    typealias Value = T
    private let _execute: () -> Single<Value>

    init<U: ReadUseCase>(_ usecase: U) where U.Value == T {
        self._execute = usecase.execute
    }
    
    func execute() -> Single<Value> {
        return _execute()
    }
}
