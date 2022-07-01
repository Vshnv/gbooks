import Foundation
import UIKit

class UIImageLoader {
    static let shared = UIImageLoader()
    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()


    func load(from url: URL, for imageView: UIImageView) {
        let token = imageLoader.loadImage(from: url) { result in
            defer { self.uuidMap.removeValue(forKey: imageView) }
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch {
        
            }
        }
        if let token = token {
            uuidMap[imageView] = token
        }
    }

    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancalLoad(for: uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}

extension UIImageView {
  func loadImage(at url: URL) {
      UIImageLoader.shared.load(from: url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.shared.cancel(for: self)
  }
}
