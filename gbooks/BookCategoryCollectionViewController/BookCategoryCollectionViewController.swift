import UIKit

class BookCategoryCollectionViewController: UICollectionViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createRootCollectionLayout()
        setupDataSource()
        setupSearchButton()
    }
    
    
    private func createRootCollectionLayout() -> UICollectionViewCompositionalLayout {
        var layout = UICollectionLayoutListConfiguration(appearance: .grouped)
        layout.backgroundColor = .clear
        layout.showsSeparators = false
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),heightDimension: .absolute(200)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return UICollectionViewCompositionalLayout.list(using: layout)
    }
    
    private func setupDataSource() {
        
    }
    
    private func setupSearchButton() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onSearchButtonPress(_:)))
        searchButton.accessibilityLabel = NSLocalizedString("Search Books", comment: "search books accessibility label")
        navigationItem.rightBarButtonItem = searchButton
    }
}

