import Foundation
import UIKit

class UIImageLoader {
    static let shared = UIImageLoader()
    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()


    func load(from url: URL, for imageView: UIImageView, animate: Bool) {
        cancel(for: imageView)
        if animate {
            imageView.showActivityIndicator()
        }
        let token = imageLoader.loadImage(from: url) { result in
            defer { self.uuidMap.removeValue(forKey: imageView) }
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                    imageView.hideActivityIndicator()
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
            imageView.hideActivityIndicator()
            imageLoader.cancalLoad(for: uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}

extension UIImageView {
  func loadImage(at url: URL, useActivityIndicator animate: Bool = true) {
      UIImageLoader.shared.load(from: url, for: self, animate: animate)
  }

  func cancelImageLoad() {
    UIImageLoader.shared.cancel(for: self)
  }
}
extension UIView {
    private static var activeIndicators = [UIView: UIActivityIndicatorView]()

    func showActivityIndicator() {
        let remnant = UIView.activeIndicators[self]
        let view = remnant ?? UIActivityIndicatorView()
        UIView.activeIndicators[self] = view
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.startAnimating()
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func hideActivityIndicator() {
        if let view = UIView.activeIndicators[self] {
            view.removeFromSuperview()
            UIView.activeIndicators.removeValue(forKey: self)
        }
    }
}
