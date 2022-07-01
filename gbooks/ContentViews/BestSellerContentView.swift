import UIKit

class BestSellerContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var rank: Int?
        var title: String?
        var description: String?
        var thumbnailImage: String?
        
        func makeContentView() -> UIView & UIContentView {
            return BestSellerContentView(self)
        }
        
        func updated(for state: UIConfigurationState) -> BestSellerContentView.Configuration {
            self
        }
    }
    
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private let rankLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 15)
        return lbl
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    private let thumbnailImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setupLayout(backgroundImageView: backgroundImageView, rankLabel: rankLabel, titleLabel: titleLabel, descriptionLabel: descriptionLabel, thumbnailImageView: thumbnailImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        rankLabel.text = configuration.rank?.description ?? ""
        titleLabel.text = configuration.title
        titleLabel.sizeThatFits(CGSize(width: 50, height: 100))
        descriptionLabel.text = configuration.description
        let attributedText = NSMutableAttributedString(
                string: configuration.description ?? "",
                attributes: [:]
        )
        let range = NSRange(location: 0, length: attributedText.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        descriptionLabel.attributedText = attributedText
        backgroundImageView.image = nil
        thumbnailImageView.image = nil
        backgroundImageView.cancelImageLoad()
        thumbnailImageView.cancelImageLoad()
        if configuration.thumbnailImage != nil {
            guard var urlComponents = URLComponents(string: configuration.thumbnailImage!) else {
                return
            }
            urlComponents.scheme = "https"
            guard let url = urlComponents.url else {
                return
            }
            backgroundImageView.loadImage(at: url)
            thumbnailImageView.loadImage(at: url)
        }
    }
}

class LoadingBestSellerCell: UICollectionViewCell {
    static let reuseIdentifier = "LoadingBestSellerCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        let activityIndicator = UIActivityIndicatorView()
        view.addSubview(activityIndicator)
        view.backgroundColor = .systemGray5
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 150),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            view.alpha = 0.25
        }, completion: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UICollectionViewListCell {
    func bestSellerConfiguration() -> BestSellerContentView.Configuration {
        return BestSellerContentView.Configuration()
    }
}
