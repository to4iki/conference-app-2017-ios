extension Sequence {
    func convert<U>(to type: U.Type) -> [U] {
        return reduce([]) { (acc: [U], e: Iterator.Element) -> [U] in
            if let e = e as? U {
                return acc + [e]
            } else {
                return acc
            }
        }
    }
}
