import Foundation

class HttpClientGoogleBooksApi: GoogleBooksApi {
    
    private let client: HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }

    func fetchVolumes(_ query: String?, subject: Subject = .none, startIndex: Int = 0, maxResults: Int = 10) async throws -> VolumesFetchResult {
        return try await client.get(
            url: GoogleBooks.apiUrl,
            path: GoogleBooks.fetchVolumesPath,
            parameters: [
                "key" : GoogleBooks.apiKey,
                "projection" : "lite",
                "q" : subject.queryPrefix + (query ?? ""),
                "startIndex" : "\(startIndex)",
                "maxResults" : "\(maxResults)"
            ],
            decodeTo: VolumesFetchResult.self
        )
    }
    
    func fetchVolumes(byIsbn isbn: String) async throws -> VolumesFetchResult {
        return try await client.get(
            url: GoogleBooks.apiUrl,
            path: GoogleBooks.fetchVolumesPath,
            parameters: [
                "key" : GoogleBooks.apiKey,
                "projection" : "lite",
                "q" : "isbn:\(isbn)",
            ],
            decodeTo: VolumesFetchResult.self
        )
    }
}


enum Subject: String {
    case thriller = "thriller"
    case travel = "travel"
    case fiction = "fiction"
    case health = "health"
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
    static let apiKey = "AIzaSyA2m3n1rT2ACRzJfbqeqCjkM3yZ6RXmt24"
    static let apiUrl = "https://www.googleapis.com"
    static let fetchVolumesPath = "/books/v1/volumes"
}
