import UIKit

struct CellSetting {
    enum Width: CGFloat {
        case header = 44
        case `default` = 132

        init(for column: Int) {
            if column == Header.columnIndex {
                self = .header
            } else {
                self = .default
            }
        }
    }
    
    enum Height: CGFloat {
        case header = 44
        case `default` = 22

        init(for row: Int) {
            if row == Header.rowIndex {
                self = .header
            } else {
                self = .default
            }
        }
    }

    struct Header {
        static let columnIndex = 0
        static let rowIndex = 0
        static let numberOfColumns = 1
        static let numberOfRows = 1
    }
}
