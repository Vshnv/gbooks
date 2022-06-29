import UIKit
import Foundation

class SmallBookPreviewContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var bookThumbnail: UIImage?
        
        func makeContentView() -> UIView & UIContentView {
            return SmallBookPreviewContentView(self)
        }
        
        func updated(for state: UIConfigurationState) -> SmallBookPreviewContentView.Configuration {
            self
        }
    }
    
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.backgroundColor = .red
        return img
    }()
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray6
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 2.5),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2.5),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        imageView.image = configuration.bookThumbnail
        imageView.setNeedsLayout()
    }
}

extension UICollectionViewListCell {
    func smallBookPreviewConfiguration() -> SmallBookPreviewContentView.Configuration {
        return SmallBookPreviewContentView.Configuration()
    }
}
