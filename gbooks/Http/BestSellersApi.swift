import Foundation

protocol BestSellersApi {
    func fetchBestSellers(subject: Subject) async throws -> BestSellerFetchRequest
}
