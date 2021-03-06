import Foundation

struct BestSellerFetchResult: Codable {
    let status: String
    let copyright: String
    let numResults: Int
    let lastModified: String
    let results: Result

    struct Result: Codable {
        let listName: String
        let bestsellersDate: String
        let publishedDate: String
        let displayName: String
        let normalListEndsAt: Int
        let updated: String
        let books: [BestSeller]
        let corrections: [String]
    }
}

struct BestSeller: Codable {
    let rank: Int
    let rankLastWeek: Int
    let weeksOnList: Int
    let asterisk: Int
    let dagger: Int
    let primaryIsbn10: String
    let primaryIsbn13: String
    let publisher: String
    let description: String
    let price: String
    let title: String
    let author: String
    let contributor: String
    let contributorNote: String?
    let bookImage: String
    let amazonProductUrl: String
    let ageGroup: String
    let bookReviewLink: String
    let firstChapterLink: String
    let sundayReviewLink: String
    let articleChapterLink: String
    let isbns: [IsbnCode]

    struct IsbnCode: Codable {
        let isbn10: String
        let isbn13: String
    }

}
