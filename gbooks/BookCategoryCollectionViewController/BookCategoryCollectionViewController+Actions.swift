import Foundation
import UIKit

extension BookCategoryCollectionViewController {
    
    @objc func onSearchButtonPress(_ sender: UIBarButtonItem) {
        print("Search")
        let api: GoogleBooksApi = HttpClientGoogleBooksApi(client: HttpClient(session: URLSession.shared))
        Task {
            let result = try! await api.fetchVolumes(nil, subject: .manga)
            print(result.totalItems)
        }
    }

}
