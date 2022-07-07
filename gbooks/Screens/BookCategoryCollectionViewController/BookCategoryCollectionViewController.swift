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

    @MainActor var volumeData: [Section: VolumeLoadState] = [
        .thriller: .notLoaded,
        .fiction: .notLoaded,
        .manga: .notLoaded,
        .sports: .notLoaded
    ]

    @MainActor var bestSellerData: [Section: BestSellerLoadState] = [
        .bestSellersHealth: .notLoaded,
        .bestSellersTravel: .notLoaded
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
        collectionView.showActivityIndicator()
        updateSnapshot()
        Task(priority: .background) {
            await loadVolumeData()
            await loadBestSellerData()
            updateSnapshot()
        }
    }

    @MainActor private func setVolumeData(section: Section, volumesLoadState: VolumeLoadState) {
        volumeData[section] = volumesLoadState
    }

    @MainActor private func setBestsellerData(section: Section, bestSellersLoadState: BestSellerLoadState) {
        bestSellerData[section] = bestSellersLoadState
    }

    func loadVolumeData() async {
        await withTaskGroup(of: (Section, [Volume]).self) { group in
            for section in volumeData.keys {
                group.addTask(priority: .medium) {
                    do {
                        return (
                            section,
                            try await self.booksApi.fetchVolumes(
                                nil,
                                subject: section.subject,
                                maxResults: 12
                            ).items
                        )
                    } catch {
                        print("Exception while loading section <\(section)>")
                        print(error)
                    }
                    return (section, [Volume]())
                }
            }
            for await (section, volumes) in group {
                setVolumeData(section: section, volumesLoadState: .loaded(data: volumes))
                updateSnapshot()
            }
        }
    }

    func loadBestSellerData() async {
        await withTaskGroup(of: (Section, [BestSeller]).self) { group in
            for section in bestSellerData.keys {
                group.addTask(priority: .medium) {
                    do {
                        return (
                            section,
                            try await self.bestSellersApi.fetchBestSellers(
                                subject: section.subject
                            ).results.books
                        )
                    } catch {
                        print("Exception while loading section <\(section)>")
                        print(error)
                    }
                    return (section, [BestSeller]())
                }
            }
            for await (section, bestSellers) in group {
                setBestsellerData(
                    section: section,
                    bestSellersLoadState: .loaded(data: bestSellers))
                updateSnapshot()
            }
        }
    }

    private func setupSearchButton() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onSearchButtonPress(_:)))
        searchButton.accessibilityLabel = NSLocalizedString("Search Books", comment: "search books accessibility label")
        navigationItem.rightBarButtonItem = searchButton
    }

}
