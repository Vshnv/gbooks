import UIKit
import Foundation

extension BookCategoryCollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    internal func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        let sectionHeaderRegistration = UICollectionView.SupplementaryRegistration(elementKind: HeadingLabelReusableView.elementKind, handler: self.supplementarySectionHeaderRegistrationHandler)
        let viewHeaderRegistration = UICollectionView.SupplementaryRegistration(elementKind: MockTopHeader.elementKind, handler: self.supplementaryViewHeaderRegistrationHandler)
        dataSource.supplementaryViewProvider = { supplementaryView, elementKind, indexPath in
            switch elementKind {
            case HeadingLabelReusableView.elementKind:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: sectionHeaderRegistration, for: indexPath)
            case MockTopHeader.elementKind:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: viewHeaderRegistration, for: indexPath)
            default:
                fatalError("Unknown element kind found in Book Category Layout")
            }
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
        var contentConfiguration = cell.smallBookPreviewConfiguration()
        contentConfiguration.bookThumbnail = UIImage(named: "sample-cover")
        contentConfiguration.bookTitle = "Percy Jackson and the Lightning Theif in the multiverse of madness"
        cell.contentConfiguration = contentConfiguration
    }
    
    private func supplementarySectionHeaderRegistrationHandler(header: HeadingLabelReusableView, elementKind: String, indexPath: IndexPath) {
        header.text = "Heading"
    }
    private func supplementaryViewHeaderRegistrationHandler(mockHeader: MockTopHeader, elementKind: String, indexPath: IndexPath) {
        mockHeader.backgroundColor = .random
    }
}
