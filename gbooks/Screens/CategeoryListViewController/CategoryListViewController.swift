import UIKit
import Foundation

class CategoryListViewController: UICollectionViewController {

    var dataSource: DataSource!

    let booksApi: GoogleBooksApi

    var data: [Volume]
    var subject: Subject
    var hasMore: Bool = true
    var isLoadingMore: Bool = false
    var loadTask: Task<Void, Error>?

    init(booksApi: GoogleBooksApi, data: [Volume], subject: Subject) {
        self.booksApi = booksApi
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
