import UIKit
import Foundation

class CategoryListViewController: UICollectionViewController {
    
    var dataSource: DataSource!
    
    let booksApi = HttpClientGoogleBooksApi(
        client: HttpClient(
            session: URLSession.shared,
            decoder: JSONDecoder()
        )
    )
    
    var data: [Volume]
    var hasMore: Bool = true
    var isLoadingMore: Bool = false
    var loadTask: Task<Void, Error>?
    
    init(data: [Volume]) {
        self.data = data
        super.init(collectionViewLayout: CategoryListViewController.createRootCollectionLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
    }
}
