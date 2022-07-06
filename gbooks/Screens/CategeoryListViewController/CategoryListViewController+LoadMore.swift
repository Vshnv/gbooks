import Foundation
import UIKit

extension CategoryListViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard elementKind == ActivityIndicatorReusableView.elementKind, let indicator = view as? ActivityIndicatorReusableView else {
            return
        }
        if !hasMore || loadTask != nil {
            return
        }
        tryLoadMore()
        indicator.activityIndicator.startAnimating()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        guard elementKind == ActivityIndicatorReusableView.elementKind, let indicator = view as? ActivityIndicatorReusableView else {
            return
        }
        indicator.activityIndicator.stopAnimating()
    }
    
    func tryLoadMore() {
        if loadTask != nil {
            return
        }
        loadTask = Task(priority: .background) {
            var data = self.data
            var scrollToTop = false
            do {
                let results = try await booksApi.fetchVolumes(nil, subject: subject, startIndex: data.count, maxResults: 12*3)
                let newData = results.items
                data.append(contentsOf: newData)
                let total = results.totalItems
                let fetchedSize = data.count
                if data.count == newData.count {
                    scrollToTop = true
                }
                hasMore = fetchedSize < total
                self.data = data.uniqueBy(by: {$0.id})
            } catch {
                print(error)
            }
            updateSnapshot()
            loadTask = nil
            if scrollToTop {
                collectionView.scrollToItem(at: .init(item: 0, section: 0), at: .top, animated: true)
            }
        }
    }
}
