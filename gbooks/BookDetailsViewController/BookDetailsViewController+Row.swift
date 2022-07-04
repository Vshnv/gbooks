import Foundation
import UIKit

extension BookDetailsViewController {
    enum Row: Hashable {
        case image
        case header(String)
        case titleView
        case subtitleView
        case authorsView
        case author(String)
        case publisherView
        case publishDateView
        case descriptionView
    }
}
