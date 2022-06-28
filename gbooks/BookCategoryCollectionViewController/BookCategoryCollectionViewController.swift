import UIKit

class BookCategoryCollectionViewController: UICollectionViewController {
    
    var dataSource: DataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createRootCollectionLayout()
        collectionView.register(MockCell.self, forCellWithReuseIdentifier: MockCell.reuseIdentifier)

        setupDataSource()
        setupSearchButton()
        updateSnapshot()
    }
    
    
    private func createRootCollectionLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200)))
            item1.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(200)),subitems: [item1])
            let section = NSCollectionLayoutSection(group: group1)
                    section.orthogonalScrollingBehavior = .continuous
            return section
            
        }
        return layout
    }
    
    private func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            //return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return collectionView.dequeueReusableCell(withReuseIdentifier: MockCell.reuseIdentifier, for: indexPath)
        })
        collectionView.dataSource = dataSource
    }
    
    private func setupSearchButton() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onSearchButtonPress(_:)))
        searchButton.accessibilityLabel = NSLocalizedString("Search Books", comment: "search books accessibility label")
        navigationItem.rightBarButtonItem = searchButton
    }
}

class MockCell: UICollectionViewCell {
    let label = UILabel()
    static let reuseIdentifier = "MockCell-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .random
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
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
