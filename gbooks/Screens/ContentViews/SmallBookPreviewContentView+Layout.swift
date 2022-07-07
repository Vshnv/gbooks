import UIKit

extension SmallBookPreviewContentView {
    internal func setupLayout(imageView: UIImageView, titleLabel: UILabel) {
        clipsToBounds = true
        layer.cornerRadius = 10
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.addSubview(visualEffectView)
        visualEffectView.contentView.addSubview(titleLabel)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray6

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            visualEffectView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.15),
            visualEffectView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: visualEffectView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor)
        ])
    }
}
