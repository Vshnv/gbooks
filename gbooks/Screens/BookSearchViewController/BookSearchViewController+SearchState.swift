import Foundation
import UIKit

enum VolumeSearchState {
    case results(result: [Volume], hasMore: Bool)
    case searching
    case idle
}
