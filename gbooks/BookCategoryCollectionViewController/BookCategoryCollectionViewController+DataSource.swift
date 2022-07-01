import UIKit
import Foundation

extension BookCategoryCollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    internal func setupDataSource() {
        let bestSellerCellRegistration = UICollectionView.CellRegistration(handler: bestSellerCellRegistrationHandler)
        let smallBookPreviewCellRegistration = UICollectionView.CellRegistration(handler: smallBookPreviewCellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            let sectionIndex = indexPath.section
            let section = Section(rawValue: sectionIndex)
            switch section {
            case .bestSellersScience:
                fallthrough
            case .bestSellersFiction:
                return collectionView.dequeueConfiguredReusableCell(using: bestSellerCellRegistration, for: indexPath, item: itemIdentifier)
            case .thriller:
                fallthrough
            case .manga:
                fallthrough
            case .sports:
                fallthrough
            case .fiction:
                return collectionView.dequeueConfiguredReusableCell(using: smallBookPreviewCellRegistration, for: indexPath, item: itemIdentifier)
            default:
                fatalError("Unknown section inserted")
            }
        })
        let sectionHeaderRegistration = UICollectionView.SupplementaryRegistration(elementKind: HeadingLabelReusableView.elementKind, handler: self.supplementarySectionHeaderRegistrationHandler)
        let viewHeaderRegistration = UICollectionView.SupplementaryRegistration(elementKind: LogoImageReusableView.elementKind, handler: self.supplementaryViewHeaderRegistrationHandler)
        dataSource.supplementaryViewProvider = { supplementaryView, elementKind, indexPath in
            switch elementKind {
            case HeadingLabelReusableView.elementKind:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: sectionHeaderRegistration, for: indexPath)
            case LogoImageReusableView.elementKind:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: viewHeaderRegistration, for: indexPath)
            default:
                fatalError("Unknown element kind found in Book Category Layout")
            }
        }
        
        collectionView.dataSource = dataSource
    }
    
    @MainActor func updateSnapshot() {
        var snapshot = Snapshot()
        for section in Section.bestSellersFiction.rawValue...Section.sports.rawValue {
            snapshot.appendSections([section])
            let volumes: [Volume] = volumeData[Section(rawValue: section)!] ?? [Volume(kind: nil, id: "section\(section)", etag: nil, selfLink: nil, volumeInfo: nil, saleInfo: nil, accessInfo: nil, searchInfo: nil)]
            snapshot.appendItems(volumes.map{vol in vol.id ?? ""}, toSection: section)
        }
        dataSource.apply(snapshot)
    }
    
    private func bestSellerCellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        var contentConfiguration = cell.bestSellerConfiguration()
        contentConfiguration.rank = 1
        contentConfiguration.title = "Percy Jackson and the Lightning Theif"
        contentConfiguration.description = "The Lightning Thief is a light-hearted fantasy about a modern 12-year-old boy who learns that his true father is Poseidon, the Greek god of the sea. Percy sets out to become a hero by undertaking a quest across the United States to find the entrance to the Underworld and stop a war between the gods."
        contentConfiguration.thumbnailImage = UIImage(named: "sample-cover")
        cell.contentConfiguration = contentConfiguration
    }
    
    private func smallBookPreviewCellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let section = Section(rawValue: indexPath.section)!
        let volumes = volumeData[section] ?? []
        let vol = volumes.first(where: {$0.id == id})
        
        let title = vol?.volumeInfo?.title
        let thumbnailLink = vol?.volumeInfo?.imageLinks?.thumbnail
        
        var contentConfiguration = cell.smallBookPreviewConfiguration()
        contentConfiguration.bookThumbnail = thumbnailLink
        contentConfiguration.bookTitle = title
        cell.contentConfiguration = contentConfiguration
    }
    
    private func supplementarySectionHeaderRegistrationHandler(headerView: HeadingLabelReusableView, elementKind: String, indexPath: IndexPath) {
        
        let section = Section(rawValue: indexPath.section)
        headerView.text = section?.name ?? ""
    }
    
    private func supplementaryViewHeaderRegistrationHandler(logoImageView: LogoImageReusableView, elementKind: String, indexPath: IndexPath) {
        // logoImageView.backgroundColor = .random
        logoImageView.image = UIImage(named: "google-logo")
        
    }
}
