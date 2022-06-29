import UIKit


extension BestSellerContentView {
    internal func setupLayout(rankLabel: UILabel, titleLabel: UILabel, descriptionLabel: UILabel, thumbnailImageView: UIImageView) {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(thumbnailImageView)
        containerView.backgroundColor = .systemGray5
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 150),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            thumbnailImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
            thumbnailImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 110)
        ])
    }
}
