import SpreadsheetView

extension SpreadsheetView {
    func registerNib<T: Cell>(type: T.Type) {
        let className = type.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func registerNib<T: Cell>(types: [T.Type]) {
        for type in types {
            registerNib(type: type)
        }
    }

    func register<T: Cell>(type: T.Type) {
        register(type, forCellWithReuseIdentifier: type.className)
    }

    func register<T: Cell>(types: [T.Type]) {
        for type in types {
            register(type: type)
        }
    }

    func dequeueReusableCell<T: Cell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
}
