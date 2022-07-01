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
            case .bestSellersTravel:
                fallthrough
            case .bestSellersHealth:
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
        
        for sectionIndex in Section.bestSellersHealth.rawValue...Section.sports.rawValue {
            snapshot.appendSections([sectionIndex])
            let section = Section(rawValue: sectionIndex)!
            switch section {
            case .bestSellersTravel:
                fallthrough
            case .bestSellersHealth:
                let bestSellers: [BestSeller] = bestSellerData[section] ?? []
                snapshot.appendItems(bestSellers.map{bestSeller in bestSeller.primaryIsbn13 }, toSection: sectionIndex)
            case .thriller:
                fallthrough
            case .manga:
                fallthrough
            case .sports:
                fallthrough
            case .fiction:
                let volumes: [Volume] = volumeData[section] ?? []
                snapshot.appendItems(volumes.map{vol in vol.id ?? ""}, toSection: sectionIndex)
            default:
                fatalError("Unknown section inserted")
            }
        }
        dataSource.apply(snapshot)
    }
    
    private func bestSellerCellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let section = Section(rawValue: indexPath.section)!
        let bestSellers = bestSellerData[section] ?? []
        let book = bestSellers.first(where: { $0.primaryIsbn13 == id })
        var contentConfiguration = cell.bestSellerConfiguration()
        contentConfiguration.rank = book?.rank
        contentConfiguration.title = book?.title
        contentConfiguration.description = book?.description
        contentConfiguration.thumbnailImage = book?.bookImage
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
