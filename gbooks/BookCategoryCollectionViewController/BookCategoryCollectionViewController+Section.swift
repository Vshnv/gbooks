import UIKit

extension BookCategoryCollectionViewController {
    enum Section: Int, Hashable {
        case bestSellersFiction
        case thriller
        case fiction
        case bestSellersScience
        case manga
        case sports
        
        var name: String {
            switch self {
            case .bestSellersFiction:
                return NSLocalizedString("Best Sellers - Fiction", comment: "Best sellers fiction section name")
            case .thriller:
                return NSLocalizedString("Thriller", comment: "Thriller section name")
            case .fiction:
                return NSLocalizedString("Fiction", comment: "Fiction section name")
            case .bestSellersScience:
                return NSLocalizedString("Best Sellers - Science", comment: "Best sellers fiction section name")
            case .manga:
                return NSLocalizedString("Manga", comment: "Manga section name")
            case .sports:
                return NSLocalizedString("Sports", comment: "Sports section name")
            }
        }
        
        var subject: Subject {
            switch self {
            case .bestSellersFiction:
                return .fiction
            case .thriller:
                return .thriller
            case .fiction:
                return .fiction
            case .bestSellersScience:
                return .science
            case .manga:
                return .manga
            case .sports:
                return .sports
            }
        }
    }
}
