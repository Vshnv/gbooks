import Foundation
import UIKit

class HttpClient {
    private let session: URLSession
    private let decoder: JSONDecoder

    
    init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    func get<R: Codable>(url: String, path: String, parameters: [String:String], decodeTo: R.Type) async throws -> R {
        guard var urlComponents = URLComponents(string: url) else {
            throw HttpClientError.invalidUrl
        }
        urlComponents.path = path
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        guard let url = urlComponents.url else {
            throw HttpClientError.invalidComponents
        }
        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request)
        let volumeResponse = try decoder.decode(decodeTo, from: data)
        return volumeResponse
    }
}

enum HttpClientError: LocalizedError {
    case invalidUrl
    case invalidComponents
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return NSLocalizedString("Provided url was invalid", comment: "invalid url error description")
        case .invalidComponents:
            return NSLocalizedString("Provided url path or paraneters were invalid", comment: "invalid components error description")
        }
    }
}
