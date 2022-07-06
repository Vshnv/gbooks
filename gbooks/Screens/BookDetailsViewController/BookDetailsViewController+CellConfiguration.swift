import Foundation
import UIKit

extension BookDetailsViewController {
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String?) -> UIListContentConfiguration {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = title
        return configuration
    }
    
    func coverImageConfiguration(for cell: UICollectionViewListCell, with url: String?) -> ImageContentView.Configuration {
        var configuration = cell.imageContentConfiguration()
        configuration.imageUrl = url
        return configuration
    }
    
    func textViewConfiguration(for cell: UICollectionViewListCell, with text: String?) -> UIListContentConfiguration {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = text
        return configuration
    }
}
