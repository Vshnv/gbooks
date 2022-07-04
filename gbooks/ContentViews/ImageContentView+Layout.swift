import Foundation
import UIKit

extension ImageContentView {
    func setupLayout(imageView: UIImageView) {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            heightAnchor.constraint(equalToConstant: 250),
        ])
        imageView.backgroundColor = .systemGray6
    }
}
