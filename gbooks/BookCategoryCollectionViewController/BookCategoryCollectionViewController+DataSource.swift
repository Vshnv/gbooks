import UIKit
import Foundation

extension BookCategoryCollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    internal func setupDataSource() {
        let bestSellerCellRegistration = UICollectionView.CellRegistration(handler: bestSellerCellRegistrationHandler)
        let smallBookPreviewCellRegistration = UICollectionView.CellRegistration(handler: smallBookPreviewCellRegistrationHandler)
        collectionView.register(LoadingBestSellerCell.self, forCellWithReuseIdentifier: LoadingBestSellerCell.reuseIdentifier)
        collectionView.register(LoadingSmallBookPreviewCell.self, forCellWithReuseIdentifier: LoadingSmallBookPreviewCell.reuseIdentifier)
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            let sectionIndex = indexPath.section
            let section = Section(rawValue: sectionIndex)!
            switch section {
            case .bestSellersTravel:
                fallthrough
            case .bestSellersHealth:
                let bestSellersState = self.bestSellerData[section] ?? .error(message: "Not Found")
                switch bestSellersState {
                case .loaded(_):
                    return collectionView.dequeueConfiguredReusableCell(using: bestSellerCellRegistration, for: indexPath, item: itemIdentifier)
                case .notLoaded:
                    return collectionView.dequeueReusableCell(withReuseIdentifier: LoadingBestSellerCell.reuseIdentifier, for: indexPath)
                case .error(_):
                    return collectionView.dequeueReusableCell(withReuseIdentifier: LoadingBestSellerCell.reuseIdentifier, for: indexPath)
                }
            case .thriller:
                fallthrough
            case .manga:
                fallthrough
            case .sports:
                fallthrough
            case .fiction:
                let volumeState = self.volumeData[section] ?? .error(message: "Not Found")
                switch volumeState {
                case .loaded(_):
                    return collectionView.dequeueConfiguredReusableCell(using: smallBookPreviewCellRegistration, for: indexPath, item: itemIdentifier)
                case .notLoaded:
                    return collectionView.dequeueReusableCell(withReuseIdentifier: LoadingSmallBookPreviewCell.reuseIdentifier, for: indexPath)
                case .error(_):
                    return collectionView.dequeueReusableCell(withReuseIdentifier: LoadingSmallBookPreviewCell.reuseIdentifier, for: indexPath)
                }
            @unknown default:
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
        collectionView.hideActivityIndicator()
        var snapshot = Snapshot()
        
        for sectionIndex in Section.bestSellersHealth.rawValue...Section.sports.rawValue {
            snapshot.appendSections([sectionIndex])
            let section = Section(rawValue: sectionIndex)!
            switch section {
            case .bestSellersTravel:
                fallthrough
            case .bestSellersHealth:
                let bestSellersState = bestSellerData[section] ?? .error(message: "Not Found")
                switch bestSellersState {
                case .loaded(let data):
                    snapshot.appendItems(
                        data.map{ bestSeller in bestSeller.primaryIsbn13 },
                        toSection: sectionIndex
                    )
                default:
                    snapshot.appendItems(
                        (0..<2).map{_ in UUID().uuidString},
                        toSection: sectionIndex
                    )
                }
            case .thriller:
                fallthrough
            case .manga:
                fallthrough
            case .sports:
                fallthrough
            case .fiction:
                let volumeSate = volumeData[section] ?? VolumeLoadState.error(message: "Not Found")
                switch volumeSate {
                case .loaded(let data):
                    snapshot.appendItems(
                        data.map{ volume in volume.id! },
                        toSection: sectionIndex
                    )
                default:
                    snapshot.appendItems(
                        (0..<4).map{_ in UUID().uuidString},
                        toSection: sectionIndex
                    )
                }
            default:
                fatalError("Unknown section inserted")
            }
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func bestSellerCellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let section = Section(rawValue: indexPath.section)!
        let bestSellersState = bestSellerData[section] ?? .error(message: "Not Found")
        guard case .loaded(let data) = bestSellersState else {
            return
        }
        let bestSellers = data
        let book = bestSellers[indexPath.item]
        var contentConfiguration = cell.bestSellerConfiguration()
        contentConfiguration.rank = book.rank
        contentConfiguration.title = book.title
        contentConfiguration.description = book.description
        contentConfiguration.thumbnailImage = book.bookImage
        cell.contentConfiguration = contentConfiguration
    }
    
    private func smallBookPreviewCellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let section = Section(rawValue: indexPath.section)!
        let volumesState = volumeData[section] ?? .error(message: "Not Found")
        guard case .loaded(let data) = volumesState else {
            return
        }
        let volumes = data
        let vol = volumes[indexPath.item]
        
        let title = vol.volumeInfo?.title
        let thumbnailLink = vol.volumeInfo?.imageLinks?.thumbnail
        var contentConfiguration = cell.smallBookPreviewConfiguration()
        contentConfiguration.bookThumbnail = thumbnailLink
        contentConfiguration.bookTitle = title
        cell.contentConfiguration = contentConfiguration
    }
    
    private func supplementarySectionHeaderRegistrationHandler(headerView: HeadingLabelReusableView, elementKind: String, indexPath: IndexPath) {
        
        let section = Section(rawValue: indexPath.section)!
        headerView.text = section.name
        headerView.onTap = { [weak self] in
            let volumesState = self?.volumeData[section] ?? .error(message: "Not Found")
            let prefetched: [Volume]
            switch volumesState {
            case .loaded(let data):
                prefetched = data
            default:
                prefetched = []
            }
            self?.navigationController?.pushViewController(CategoryListViewController(data: prefetched), animated: true)
        }
    }
    
    private func supplementaryViewHeaderRegistrationHandler(logoImageView: LogoImageReusableView, elementKind: String, indexPath: IndexPath) {
        // logoImageView.backgroundColor = .random
        logoImageView.image = UIImage(named: "google-logo")
        
    }
}
