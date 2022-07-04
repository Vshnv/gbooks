import UIKit
import Foundation

class BookSearchViewController: UICollectionViewController {
    
    var dataSource: DataSource!
    
    let booksApi = HttpClientGoogleBooksApi(
        client: HttpClient(
            session: URLSession.shared,
            decoder: JSONDecoder()
        )
    )
    
    var searchState: VolumeSearchState = .idle
    var searchTask: Task<Void, Error>?
    
    init() {
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
        navigationItem.rightBarButtonItem = navigationItem.leftBarButtonItem
        searchBar.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {

        return false
    }
}
