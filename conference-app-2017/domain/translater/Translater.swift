protocol Translator {
    associatedtype Input
    associatedtype Output

    static func translate(_ input: Input) -> Output
}
