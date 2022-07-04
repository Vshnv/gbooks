import Foundation

protocol GoogleBooksApi {
    func fetchVolumes(_ query: String?, subject: Subject, startIndex: Int, maxResults: Int) async throws -> VolumesFetchResult
}
