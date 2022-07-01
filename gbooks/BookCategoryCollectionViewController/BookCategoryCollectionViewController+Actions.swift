import Foundation
import UIKit

extension BookCategoryCollectionViewController {
    
    @objc func onSearchButtonPress(_ sender: UIBarButtonItem) {
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
        Task {
            let result = try! await bestSellersApi.fetchBestSellers(subject: .health)
            print(result.results)
        }
    }

}
