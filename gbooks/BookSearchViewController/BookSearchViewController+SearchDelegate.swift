import UIKit
import Foundation

extension BookSearchViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTask?.cancel()
        guard let query = searchBar.text else {
            searchState = .idle
            updateSnapshot()
            return
        }
        searchState = .searching
        updateSnapshot()
        collectionView.scrollToItem(at: .init(item: 0, section: 0), at: .centeredVertically, animated: false)
        searchTask = Task(priority: .background) {
            do {
                let results = try await booksApi.fetchVolumes(query)
                let data = results.items
                let total = results.totalItems
                let fetchedSize = data.count
                searchState = .results(result: data, hasMore: fetchedSize < total)
                collectionView.scrollToItem(at: .init(item: 0, section: 0), at: .centeredVertically, animated: false)
            } catch {
                searchState = .idle
            }
            updateSnapshot()
        }
    }
}
