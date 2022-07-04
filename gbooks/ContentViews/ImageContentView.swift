import UIKit

class ImageContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var imageUrl: String?
        
        func makeContentView() -> UIView & UIContentView {
            return ImageContentView(self)
        }
        func updated(for state: UIConfigurationState) -> ImageContentView.Configuration {
            self
        }
    }
    
    private let imageView = UIImageView()
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 44)
    }
    
    init(_ contentConfiguration: UIContentConfiguration) {
        self.configuration = contentConfiguration
        super.init(frame: .zero)
        setupLayout(imageView: imageView)
        imageView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        guard var urlComponents = URLComponents(string: configuration.imageUrl!) else {
            return
        }
        urlComponents.scheme = "https"
        guard let url = urlComponents.url else {
            return
        }
        imageView.loadImage(at: url)
    }
    
}

extension UICollectionViewListCell {
    func imageContentConfiguration() -> ImageContentView.Configuration {
        ImageContentView.Configuration()
    }
}
