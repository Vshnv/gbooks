import UIKit

/**
 * Supplementary view with activity indicator to animate 'loading' state
 */
class ActivityIndicatorReusableView: UICollectionReusableView {
    static var elementKind: String { "UICollectionView.elementKindSectionHeader" }

    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func prepareSubviews() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
