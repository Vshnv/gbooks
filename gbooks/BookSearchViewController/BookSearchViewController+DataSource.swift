import UIKit
import Foundation

extension BookSearchViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    internal func setupDataSource() {
        let searchElementCellRegistration = UICollectionView.CellRegistration(handler: searchElementCellRegistrationHandler)
        collectionView.register(LoadingSmallBookPreviewCell.self, forCellWithReuseIdentifier: LoadingSmallBookPreviewCell.reuseIdentifier)
        dataSource = DataSource(collectionView: collectionView, cellProvider: { [weak self] (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            switch self?.searchState {
            case nil:
                fallthrough
            case .idle:
                fallthrough
            case .searching:
                return collectionView.dequeueReusableCell(withReuseIdentifier: LoadingSmallBookPreviewCell.reuseIdentifier, for: indexPath)
            case .results(_,_):
                return collectionView.dequeueConfiguredReusableCell(using: searchElementCellRegistration, for: indexPath, item: itemIdentifier)
            }
        })
        let footerRegistration = UICollectionView.SupplementaryRegistration(elementKind: ActivityIndicatorReusableView.elementKind, handler: self.supplementaryViewFooterRegistrationHandler)
       
        dataSource.supplementaryViewProvider = { supplementaryView, elementKind, indexPath in
            switch elementKind {
            case ActivityIndicatorReusableView.elementKind:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
            default:
                fatalError("Unknown element kind found in Book Category Layout")
            }
        }
        collectionView.dataSource = dataSource
        updateSnapshot()
    }
    
    @MainActor func updateSnapshot() {
        collectionView.hideActivityIndicator()
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        switch searchState {
        case .idle:
            break
        case .searching:
            snapshot.appendItems((0...15).map{ "\($0)" }, toSection: 0)

        case .results(let data, _):
            snapshot.appendItems(data.map{$0.id!}, toSection: 0)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func searchElementCellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        guard case .results(let data,_) = searchState else {
            return
        }
        let vol = data[indexPath.item]
        let title = vol.volumeInfo?.title
        let thumbnailLink = vol.volumeInfo?.imageLinks?.thumbnail
        var contentConfiguration = cell.smallBookPreviewConfiguration()
        contentConfiguration.bookThumbnail = thumbnailLink
        contentConfiguration.bookTitle = title
        cell.contentConfiguration = contentConfiguration
    }
    
    private func supplementaryViewFooterRegistrationHandler(activityIndicatorReusableView: ActivityIndicatorReusableView, elementKind: String, indexPath: IndexPath) {
        
        
    }
}
