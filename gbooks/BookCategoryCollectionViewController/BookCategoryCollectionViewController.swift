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

class MockTopHeader: UICollectionReusableView {
    static var elementKind: String { "MockTopHeader" }
    
    var text: String = "" {
        didSet {
            setNeedsLayout()
            textView.text = text
            self.layoutIfNeeded()
        }
    }
    
    private let textView: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareSubviews() {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .black
        textView.font = .boldSystemFont(ofSize: 20)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
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
