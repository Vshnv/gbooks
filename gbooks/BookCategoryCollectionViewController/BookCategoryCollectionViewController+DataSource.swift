import UIKit
import Foundation

extension BookCategoryCollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        var identifierOffset = 0
        let itemsPerSection = 30
        for section in 0..<10 {
            snapshot.appendSections([section])
            let maxIdentifier = identifierOffset + itemsPerSection
            let range = identifierOffset..<maxIdentifier
            snapshot.appendItems(Array(range).map{"\($0)"}, toSection: section)
            identifierOffset += itemsPerSection
        }
        dataSource.apply(snapshot)
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = "Test"
        contentConfiguration.secondaryText = "test@123"
        cell.contentConfiguration = contentConfiguration
    }
}
