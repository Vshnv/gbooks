import UIKit

class TextViewContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var edittable: Bool = false
        var text: String? = ""
        func makeContentView() -> UIView & UIContentView {
            return TextViewContentView(self)
        }
        func updated(for state: UIConfigurationState) -> TextViewContentView.Configuration {
            self
        }
    }

    private let textView = UITextView()

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
        setupLayout(textView: textView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        textView.isEditable = configuration.edittable
        textView.text = configuration.text
        textView.sizeToFit()
        sizeToFit()
        layoutIfNeeded()
    }

}

extension UICollectionViewListCell {
    func textViewConfiguration() -> TextViewContentView.Configuration {
        TextViewContentView.Configuration()
    }
}
