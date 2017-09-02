extension String {
    var capitalizedFirst: String {
        let first = String(characters.prefix(1)).capitalized
        let tail = String(characters.dropFirst())
        return first + tail
    }
}
