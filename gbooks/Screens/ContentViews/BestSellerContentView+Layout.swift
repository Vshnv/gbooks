import UIKit


extension BestSellerContentView {
    internal func setupLayout(backgroundImageView: UIImageView, rankLabel: UILabel, titleLabel: UILabel, descriptionLabel: UILabel, thumbnailImageView: UIImageView) {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 10
        backgroundImageView.contentMode = .scaleToFill
        addSubview(backgroundImageView)
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.addSubview(visualEffectView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.contentView.addSubview(thumbnailImageView)
        //containerView.backgroundColor = .systemGray5
        visualEffectView.clipsToBounds = true
        visualEffectView.layer.cornerRadius = 10
        visualEffectView.contentView.addSubview(titleLabel)
        visualEffectView.contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 150),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            backgroundImageView.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor),
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: visualEffectView.topAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 110),
            titleLabel.topAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: -10),
            descriptionLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor, constant: -10)
        ])
    }
}
