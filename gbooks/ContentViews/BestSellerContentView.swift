import UIKit

class BestSellerContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var rank: Int?
        var title: String?
        var description: String?
        var thumbnailImage: UIImage?
        
        func makeContentView() -> UIView & UIContentView {
            return BestSellerContentView(self)
        }
        
        func updated(for state: UIConfigurationState) -> BestSellerContentView.Configuration {
            self
        }
    }
    
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
        setupLayout(rankLabel: rankLabel, titleLabel: titleLabel, descriptionLabel: descriptionLabel, thumbnailImageView: thumbnailImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        rankLabel.text = configuration.rank?.description ?? ""
        titleLabel.text = configuration.title
        titleLabel.sizeThatFits(CGSize(width: 50, height: 100))
        descriptionLabel.text = descriptionLabel.text
        thumbnailImageView.image = configuration.thumbnailImage
    }
}
extension UICollectionViewListCell {
    func bestSellerConfiguration() -> BestSellerContentView.Configuration {
        return BestSellerContentView.Configuration()
    }
}
