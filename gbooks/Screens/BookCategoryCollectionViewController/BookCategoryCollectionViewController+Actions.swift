import Foundation
import UIKit

extension BookCategoryCollectionViewController {
    
    @objc func onSearchButtonPress(_ sender: UIBarButtonItem) {
        print(navigationController?.viewControllers)
        navigationController?.pushViewController(BookSearchViewController(booksApi: booksApi), animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let section = Section(rawValue: indexPath.section) else {
            return false
        }
        
        switch section {
        case .bestSellersTravel:
            fallthrough
        case .bestSellersHealth:
            let bestSellersState = bestSellerData[section] ?? .error(message: "Not Found")
            switch bestSellersState {
            case .loaded(let data):
                let bestSeller = data[indexPath.item]
                let task = Task(priority: .background) {
                    return try await booksApi.fetchVolumes(byIsbn: bestSeller.primaryIsbn13).items.first
                }
                navigationController?.pushViewController(BookDetailsViewController(volumeTask: task), animated: true)
            default:
                break
            }
        case .thriller:
            fallthrough
        case .manga:
            fallthrough
        case .sports:
            fallthrough
        case .fiction:
            let volumeSate = volumeData[section] ?? .error(message: "Not Found")
            switch volumeSate {
            case .loaded(let data):
                let volume = data[indexPath.item]
                navigationController?.pushViewController(BookDetailsViewController(volume: volume), animated: true)
            default:
                break
            }
        default:
            fatalError("Unknown section inserted")
        }
        return false
    }
}
