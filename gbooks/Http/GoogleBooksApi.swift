import Foundation


/**
 * Interfaces the Google Books API (https://developers.google.com/books)
 */
protocol GoogleBooksApi {
    /**
     * Fetches volumes based on given query and subject
     *
     * - warning: if query is nil, subject must not be .none and vice versa
     * - parameter query: query string for title of book
     * - parameter subject: subject of book to be searched
     * - parameter startIndex: offset to actual query result from where response starts
     * - parameter maxResults: maximum number of volumes to be included in the response
     * - returns: volumes along with a some extra information about the results of the given query
     */
    func fetchVolumes(_ query: String?, subject: Subject, startIndex: Int, maxResults: Int) async throws -> VolumesFetchResult
    /**
     * Fetches a volume matching the specific isbn code
     *
     * - parameter isbn: unique isbn code of required book
     * - returns: fetch result with either a single or empty item collection depending on validity of isbn code
     */
    func fetchVolumes(byIsbn isbn: String) async throws -> VolumesFetchResult
}
