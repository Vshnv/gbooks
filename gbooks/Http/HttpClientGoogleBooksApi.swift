import Foundation

class HttpClientGoogleBooksApi: GoogleBooksApi {
    private let client: HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }
    
    func fetchVolumes(_ query: String?, subject: Subject = .none) async throws -> VolumesFetchResult {
        return try await client.get(
            url: GoogleBooks.apiUrl,
            path: GoogleBooks.fetchVolumesPath,
            parameters: [
                "key" : GoogleBooks.apiKey,
                "projection" : "lite",
                "q" : subject.queryPrefix + (query ?? "")
            ],
            decodeTo: VolumesFetchResult.self)
    }
}


enum Subject: String {
    case thriller = "thriller"
    case fiction = "fiction"
    case manga = "manga"
    case sports = "sports"
    case science = "science"
    case none = ""
    
    var queryPrefix: String {
        switch self {
        case .none:
            return ""
        default:
            return subject(self.rawValue)
        }
    }
    
    private func subject(_ name: String) -> String {
        return "subject:\(name)+"
    }
}


fileprivate enum GoogleBooks {
    static let apiKey = "AIzaSyCfaV244QzDBPAaOdDaCOkfcYxGvwMzVhA"
    static let apiUrl = "https://www.googleapis.com"
    static let fetchVolumesPath = "/books/v1/volumes"
}
