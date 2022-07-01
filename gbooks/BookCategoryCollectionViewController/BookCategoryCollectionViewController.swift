import UIKit

class BookCategoryCollectionViewController: UICollectionViewController {
    
    var dataSource: DataSource!

    let booksApi = HttpClientGoogleBooksApi(
        client: HttpClient(
            session: URLSession.shared,
            decoder: JSONDecoder()
        )
    )
    
    let bestSellersApi = HttpClientBestSellersApi(
        client: HttpClient(
            session: URLSession.shared,
            decoder: {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                return jsonDecoder
            }()
        )
    )
    
    @MainActor var volumeData : [Section:[Volume]] = [
        .thriller : [],
        .fiction : [],
        .manga : [],
        .sports : []
    ]
    
    @MainActor var bestSellerData : [Section:[BestSeller]] = [
        .bestSellersHealth : [],
        .bestSellersTravel : []
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
            await loadBestSellerData()
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
                        print(error)
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
    
    func loadBestSellerData() async {
        var res = [Section:[BestSeller]]()
        await withTaskGroup(of: (Section,[BestSeller]).self) { group in
            for section in bestSellerData.keys {
                group.addTask(priority: .medium) {
                    do {
                        return (section, try await self.bestSellersApi.fetchBestSellers(subject: section.subject).results.books)
                    } catch {
                        print("Exception while loading section <\(section)>")
                        print(error)
                    }
                    return (section, [BestSeller]())
                }
            }
            for await (section, bestSellers) in group {
                res[section] = bestSellers
            }
            bestSellerData = res
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
