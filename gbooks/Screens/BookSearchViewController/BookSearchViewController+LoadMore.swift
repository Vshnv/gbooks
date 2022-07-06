import UIKit
import Foundation

extension BookSearchViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard elementKind == ActivityIndicatorReusableView.elementKind, let indicator = view as? ActivityIndicatorReusableView else {
            return
        }
        guard case .results(_, let hasMore) = searchState, hasMore, searchTask == nil else {
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
        if searchTask != nil {
            return
        }
        searchTask = Task(priority: .background) {
            var data = [Volume]()
            var scrollToTop = false
            switch searchState {
            case .results(let currentData, _):
                data.append(contentsOf: currentData)
            default:
                break
            }
            do {
                let results = try await booksApi.fetchVolumes(query, subject: .none, startIndex: data.count, maxResults: 12*3)
                let newData = results.items
                data.append(contentsOf: newData)
                let total = results.totalItems
                let fetchedSize = data.count
                if data.count == newData.count {
                    scrollToTop = true
                }
                searchState = VolumeSearchState.results(result: data.uniqueBy{ $0.id! }, hasMore: fetchedSize < total)
            } catch {
                searchState = .idle
            }
            updateSnapshot()
            searchTask = nil
            if scrollToTop {
                collectionView.scrollToItem(at: .init(item: 0, section: 0), at: .top, animated: true)
            }
        }
    }
}

extension Array {
    func uniqueBy<T: Equatable>(by f: (Element) -> T)-> [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(where: { f(item) == f($0) }) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}
