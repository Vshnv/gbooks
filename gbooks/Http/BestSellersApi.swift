import Foundation

/**
 * Interfaces the NYT Best Sellers API (https://developer.nytimes.com/docs/books-product/1/overview)
 */
protocol BestSellersApi {
    /**
     * Fetches current list of nyt bestsellers of a given subject
     *
     * - parameter subject: subject to fetch bestsellers of
     * - returns: list of bestsellers along with a some extra information about the results of the given query
     */
    func fetchBestSellers(subject: Subject) async throws -> BestSellerFetchResult
}
