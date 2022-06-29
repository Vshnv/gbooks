import UIKit

class BookCategoryCollectionViewController: UICollectionViewController {
    
    var dataSource: DataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createRootCollectionLayout()
        //collectionView.register(MockCell.self, forCellWithReuseIdentifier: MockCell.reuseIdentifier)


        setupDataSource()
        setupSearchButton()
        updateSnapshot()
    }
    
    
    private func setupSearchButton() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onSearchButtonPress(_:)))
        searchButton.accessibilityLabel = NSLocalizedString("Search Books", comment: "search books accessibility label")
        navigationItem.rightBarButtonItem = searchButton
    }
    
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 0.7)
    }
}
