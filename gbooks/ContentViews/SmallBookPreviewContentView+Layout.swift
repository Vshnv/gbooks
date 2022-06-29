import UIKit

extension SmallBookPreviewContentView {
    internal func setupLayout(imageView: UIImageView, titleLabel: UILabel) {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.addSubview(visualEffectView)
        visualEffectView.contentView.addSubview(titleLabel)
        backgroundColor = .systemGray6
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 2.5),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2.5),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            visualEffectView.centerXAnchor.constraint(equalTo: centerXAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            visualEffectView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 150),
            visualEffectView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: visualEffectView.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: -5)
        ])
    }
}
