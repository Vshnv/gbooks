import UIKit

extension BookCategoryCollectionViewController {
    enum Section: Int, Hashable {
        case bestSellersHealth
        case thriller
        case fiction
        case bestSellersTravel
        case manga
        case sports
        
        var name: String {
            switch self {
            case .bestSellersHealth:
                return NSLocalizedString("Best Sellers - Health", comment: "Best sellers health section name")
            case .thriller:
                return NSLocalizedString("Thriller", comment: "Thriller section name")
            case .fiction:
                return NSLocalizedString("Fiction", comment: "Fiction section name")
            case .bestSellersTravel:
                return NSLocalizedString("Best Sellers - Travel", comment: "Best sellers travel section name")
            case .manga:
                return NSLocalizedString("Manga", comment: "Manga section name")
            case .sports:
                return NSLocalizedString("Sports", comment: "Sports section name")
            }
        }
        
        var subject: Subject {
            switch self {
            case .bestSellersHealth:
                return .health
            case .thriller:
                return .thriller
            case .fiction:
                return .fiction
            case .bestSellersTravel:
                return .travel
            case .manga:
                return .manga
            case .sports:
                return .sports
            }
        }
    }
}
