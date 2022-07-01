import UIKit
import Foundation

class SmallBookPreviewContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var bookThumbnail: String?
        var bookTitle: String?
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
        img.backgroundColor = .systemGray2
        return img
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        return lbl
    }()
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }


    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setupLayout(imageView: imageView, titleLabel: titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        titleLabel.text = configuration.bookTitle
        imageView.image = nil
        imageView.cancelImageLoad()
        if configuration.bookThumbnail != nil {
            guard var urlComponents = URLComponents(string: configuration.bookThumbnail!) else {
                return
            }
            urlComponents.scheme = "https"
            guard let url = urlComponents.url else {
                return
            }
            imageView.loadImage(at: url)
        }
    }
}

class LoadingSmallBookPreviewCell: UICollectionViewCell {
    static let reuseIdentifier = "LoadingSmallBookPreviewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        let activityIndicator = UIActivityIndicatorView()
        clipsToBounds = true
        layer.cornerRadius = 20
        contentView.addSubview(activityIndicator)
        contentView.backgroundColor = .systemGray6
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 200),
            contentView.widthAnchor.constraint(equalToConstant: 150),
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: { [weak self] in

            self?.contentView.alpha = 0.25

        }, completion: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UICollectionViewListCell {
    func smallBookPreviewConfiguration() -> SmallBookPreviewContentView.Configuration {
        return SmallBookPreviewContentView.Configuration()
    }
}
