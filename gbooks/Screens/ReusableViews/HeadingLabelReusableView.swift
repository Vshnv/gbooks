import UIKit

/**
 * Supplementary header label reusable view with onTap guesture and disclosure indicator
 */
class HeadingLabelReusableView: UICollectionReusableView {
    static var elementKind: String { UICollectionView.elementKindSectionHeader }

    var text: String = "" {
        didSet {
            setNeedsLayout()
            label.text = text
            self.layoutIfNeeded()
        }
    }

    var onTap: () -> Void = {}

    private let label: UILabel = UILabel()

    private let imageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onViewTapped))
        addGestureRecognizer(tapGesture)
    }

    @objc func onViewTapped() {
        onTap()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func prepareSubviews() {
        addSubview(label)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)

        ])
    }
}
