import SwinjectStoryboard

extension SwinjectStoryboard {
    static func setup() {
        let container = defaultContainer
        DataContainer.register(container: container)
        DomainContainer.register(container: container)
        PresentationContainer.register(container: container)
    }
}
