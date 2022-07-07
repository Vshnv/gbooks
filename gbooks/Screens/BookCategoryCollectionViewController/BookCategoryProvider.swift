import Foundation

typealias Section = BookCategoryCollectionViewController.Section

@MainActor
class BookCategoryProvider {

    private let booksApi = HttpClientGoogleBooksApi(
        client: HttpClient(
            session: URLSession.shared,
            decoder: JSONDecoder()
        )
    )

    private let bestSellersApi = HttpClientBestSellersApi(
        client: HttpClient(
            session: URLSession.shared,
            decoder: {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                return jsonDecoder
            }()
        )
    )

    private var volumeData: [Section: VolumeLoadState] = [
        .thriller: .notLoaded,
        .fiction: .notLoaded,
        .manga: .notLoaded,
        .sports: .notLoaded
    ]

    private var bestSellerData: [Section: BestSellerLoadState] = [
        .bestSellersHealth: .notLoaded,
        .bestSellersTravel: .notLoaded
    ]

    func getVolumeData(section: Section) -> VolumeLoadState? {
        return volumeData[section]
    }

    func loadVolumeData(section: Section) async {
        await Task(priority: .background) {
            do {
                volumeData[section] = .loaded(data: try await self.booksApi.fetchVolumes(nil, subject: section.subject).items)
            } catch {
                print("Error loading volume data \(error)")
                volumeData[section] = .error(message: "Failed to load!")
            }
        }.value
    }
}
