import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    static func setup() {
        // disable since doesn't work with storyboard plugin
        Container.loggingFunction = nil
        
        let container = defaultContainer
        DataContainer.register(container: container)
        DomainContainer.register(container: container)
        PresentationContainer.register(container: container)
    }
}
