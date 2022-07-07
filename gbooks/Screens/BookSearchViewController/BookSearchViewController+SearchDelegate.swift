import UIKit
import Foundation

extension BookSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTask?.cancel()
        guard let query = searchBar.text else {
            searchState = .idle
            updateSnapshot()
            return
        }
        searchState = .searching
        updateSnapshot()
        self.query = query
        tryLoadMore()
    }
}
