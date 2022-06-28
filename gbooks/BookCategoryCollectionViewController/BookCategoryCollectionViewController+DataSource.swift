import UIKit
import Foundation

extension BookCategoryCollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    internal func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            //return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return collectionView.dequeueReusableCell(withReuseIdentifier: MockCell.reuseIdentifier, for: indexPath)
        })
        let headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: MockHeader.elementKind, handler: supplementaryRegistrationHandler)
        
        dataSource.supplementaryViewProvider = { supplementaryView, elementKind, indexPath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        collectionView.dataSource = dataSource
    }
    
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
    
    private func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = "Test"
        contentConfiguration.secondaryText = "test@123"
        cell.contentConfiguration = contentConfiguration
    }
    
    private func supplementaryRegistrationHandler(mockHeader: MockHeader, elementKind: String, indexPath: IndexPath) {
        mockHeader.text = "Heading"
    }
}
