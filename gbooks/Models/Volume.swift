import Foundation

struct VolumesFetchResult: Codable {
    let kind: String
    let totalItems: Int
    let items: [Volume]
}

/*
    Refers to a LITE projection Volume from Google Books API v1 (https://developers.google.com/books)
 */
struct Volume: Codable {
    let kind: String?
    let id: String?
    let etag: String?
    let selfLink: String?
    let volumeInfo: Info?
    let saleInfo: SaleInfo?
    let accessInfo: AccessInfo?
    let searchInfo: SearchInfo?
}

struct Info: Codable {
    let title: String?
    let subtitle: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let contentVersion: String?
    let imageLinks: ImageLinks?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
    struct ImageLinks: Codable {
        let smallThumbnail: String?
        let thumbnail: String?
    }
}
struct SaleInfo: Codable {
    let country: String?
}
struct AccessInfo: Codable {
    let country: String?
    let epub: Availability?
    let pdf: Availability?
    let accessViewStatus: String?

    struct Availability: Codable {
        let isAvailable: Bool?
    }
}
struct SearchInfo: Codable {
    let textSnippet: String?
}
