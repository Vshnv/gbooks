import Foundation

enum VolumeLoadState {
    case notLoaded
    case loaded(data: [Volume])
    case error(message: String)
}

enum BestSellerLoadState {
    case notLoaded
    case loaded(data: [BestSeller])
    case error(message: String)
}
