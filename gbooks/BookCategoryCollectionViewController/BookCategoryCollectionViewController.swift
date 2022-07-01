import UIKit

class BookCategoryCollectionViewController: UICollectionViewController {
    
    var dataSource: DataSource!

    let booksApi = HttpClientGoogleBooksApi(
        client: HttpClient(
            session: URLSession.shared,
            decoder: JSONDecoder()
        )
    )
    @MainActor var volumeData : [BookCategoryCollectionViewController.Section:[Volume]] = [
        .thriller : [],
        .fiction : [],
        .manga : [],
        .sports : []
    ]
    
    internal let iconBarButton: UIBarButtonItem = {
        let icon = UIImageView(image: UIImage(named: "google-logo"))
        icon.accessibilityLabel = NSLocalizedString("GBooks", comment: "gbooks icon accessibility label")
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        let barButton = UIBarButtonItem(customView: icon)
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createRootCollectionLayout()
        setupDataSource()
        setupSearchButton()
        updateSnapshot()
        Task {
            await loadVolumeData()
            updateSnapshot()
        }
    }
    
    func loadVolumeData() async {
        var res = [Section:[Volume]]()
        await withTaskGroup(of: (Section,[Volume]).self) { group in
            for section in volumeData.keys {
                group.addTask(priority: .medium) {
                    do {
                        return (section, try await self.booksApi.fetchVolumes(nil, subject: section.subject).items)
                    } catch {
                        print("Exception while loading section <\(section)>")
                    }
                    return (section, [Volume]())
                }
            }
            for await (section, volumes) in group {
                res[section] = volumes
            }
            volumeData = res
        }
    }
    
    
    
    private func setupSearchButton() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onSearchButtonPress(_:)))
        searchButton.accessibilityLabel = NSLocalizedString("Search Books", comment: "search books accessibility label")
        navigationItem.rightBarButtonItem = searchButton
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
