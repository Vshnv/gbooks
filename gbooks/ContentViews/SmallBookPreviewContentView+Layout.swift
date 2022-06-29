import UIKit

extension SmallBookPreviewContentView {
    internal func setupLayout(imageView: UIImageView, titleLabel: UILabel) {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.addSubview(visualEffectView)
        visualEffectView.contentView.addSubview(titleLabel)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 200),
            widthAnchor.constraint(equalToConstant: 150),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 2.5),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2.5),
            visualEffectView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            visualEffectView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 150),
            visualEffectView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: visualEffectView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor)
        ])
        /*NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            visualEffectView.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: visualEffectView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor)
        ])*/
    }
}
