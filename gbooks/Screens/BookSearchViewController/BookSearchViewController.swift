import UIKit
import Foundation

class BookSearchViewController: UICollectionViewController {
    
    var dataSource: DataSource!
    
    let booksApi: GoogleBooksApi
    var query: String?
    var searchState: VolumeSearchState = .idle
    var isLoadingMore: Bool = false
    var searchTask: Task<Void, Error>?
    
    init(booksApi: GoogleBooksApi) {
        self.booksApi = booksApi
        super.init(collectionViewLayout: BookSearchViewController.createRootCollectionLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupDataSource()
    }
    
    private func setupSearchBar() {
        let searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }

}
