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
    var subject: Subject
    var hasMore: Bool = true
    var isLoadingMore: Bool = false
    var loadTask: Task<Void, Error>?
    
    init(data: [Volume], subject: Subject) {
        self.data = data
        self.subject = subject
        super.init(collectionViewLayout: CategoryListViewController.createRootCollectionLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        navigationItem.title = subject.rawValue
    }
}
