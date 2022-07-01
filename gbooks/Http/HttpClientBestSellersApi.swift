import Foundation
import UIKit

class HttpClientBestSellersApi: BestSellersApi {
    
    private let client: HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }
    
    func fetchBestSellers(subject: Subject) async throws -> BestSellerFetchResult {
        return try await client.get(
            url: "https://api.nytimes.com",
            path: String(format: BestSellers.fetchVolumesPath, subject.rawValue),
            parameters: ["api-key": BestSellers.apiKey],
            decodeTo: BestSellerFetchResult.self
        )
    }
}

fileprivate enum BestSellers {
    static let apiKey = "VuZ1GWA5eSfnW5m4QHSNtIKuXMmJZvtx"
    static let apiUrl = "https://api.nytimes.com"
    static let fetchVolumesPath = "/svc/books/v3/lists/current/%@.json"
}
