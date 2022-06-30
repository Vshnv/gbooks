import UIKit

class BookCategoryCollectionViewController: UICollectionViewController {
    
    var dataSource: DataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createRootCollectionLayout()
        //collectionView.register(MockCell.self, forCellWithReuseIdentifier: MockCell.reuseIdentifier)
        
        setupDataSource()
        setupSearchButton()
        setupIcon()
        updateSnapshot()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y > 225)
    }
    
    
    private func setupSearchButton() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onSearchButtonPress(_:)))
        searchButton.accessibilityLabel = NSLocalizedString("Search Books", comment: "search books accessibility label")
        navigationItem.rightBarButtonItem = searchButton
    }
    
    private func setupIcon() {
        let icon = UIImageView(image: UIImage(named: "google-logo"))
        icon.accessibilityLabel = NSLocalizedString("GBooks", comment: "gbooks icon accessibility label")
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        let barButton = UIBarButtonItem(customView: icon)
        navigationItem.leftBarButtonItem = barButton
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {

        return false
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
