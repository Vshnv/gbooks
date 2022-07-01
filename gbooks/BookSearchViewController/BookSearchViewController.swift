import UIKit
import Foundation

class BookSearchViewController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: BookSearchViewController.createRootCollectionLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MockCell.self, forCellWithReuseIdentifier: MockCell.reuseIdentifier)
        setupSearchBar()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: MockCell.reuseIdentifier, for: indexPath)
    }
    
    private func setupSearchBar() {
        let searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = navigationItem.leftBarButtonItem
    }
}

class MockCell: UICollectionViewCell {
    static let reuseIdentifier = "MockCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        contentView.backgroundColor = .blue
        contentView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
       // contentView.transform.rotated(by: 50)
    }
}
