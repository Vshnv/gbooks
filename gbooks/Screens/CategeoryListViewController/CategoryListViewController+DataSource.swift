import Foundation
import UIKit

extension CategoryListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>

    internal func setupDataSource() {
        let tileElementCellRegistration = UICollectionView.CellRegistration {
            [weak self] (cell: UICollectionViewListCell, indexPath: IndexPath, _: String) in
            let vol = self?.data[indexPath.item]
            let title = vol?.volumeInfo?.title
            let thumbnailLink = vol?.volumeInfo?.imageLinks?.thumbnail
            var contentConfiguration = cell.smallBookPreviewConfiguration()
            contentConfiguration.bookThumbnail = thumbnailLink
            contentConfiguration.bookTitle = title
            cell.contentConfiguration = contentConfiguration
        }
        collectionView.register(LoadingSmallBookPreviewCell.self, forCellWithReuseIdentifier: LoadingSmallBookPreviewCell.reuseIdentifier)
        dataSource = DataSource(collectionView: collectionView, cellProvider: { [weak self] (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            if (self?.isLoadingMore ?? false) && (self?.data.isEmpty ?? false) {
                return collectionView.dequeueReusableCell(withReuseIdentifier: LoadingSmallBookPreviewCell.reuseIdentifier, for: indexPath)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: tileElementCellRegistration, for: indexPath, item: itemIdentifier)
            }
        })
        let footerRegistration = UICollectionView.SupplementaryRegistration(elementKind: ActivityIndicatorReusableView.elementKind) {
            (_: ActivityIndicatorReusableView, _: String, _: IndexPath) in
        }

        dataSource.supplementaryViewProvider = { [weak self] _, elementKind, indexPath in
            switch elementKind {
            case ActivityIndicatorReusableView.elementKind:
                return self?.collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
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
        if isLoadingMore && data.isEmpty {
            snapshot.appendItems((0...15).map { "\($0)" }, toSection: 0)
        } else {
            snapshot.appendItems(data.map {$0.id!}, toSection: 0)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
