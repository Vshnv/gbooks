import UIKit
import Foundation

class SmallBookPreviewContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var bookThumbnail: UIImage?
        var bookTitle: String
        
        func makeContentView() -> UIView & UIContentView {
            return SmallBookPreviewContentView(self)
        }
        
        func updated(for state: UIConfigurationState) -> SmallBookPreviewContentView.Configuration {
            self
        }
    }
    private let imageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        imageView.image = configuration.bookThumbnail
        titleLabel.text = configuration.bookTitle
    }
}
