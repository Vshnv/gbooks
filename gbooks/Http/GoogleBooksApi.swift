import Foundation

protocol GoogleBooksApi {
    func fetchVolumes(_ query: String?, subject: Subject) async throws -> VolumesFetchResult
}
