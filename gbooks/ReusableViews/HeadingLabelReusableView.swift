import UIKit

class HeadingLabelReusableView: UICollectionReusableView {
    static var elementKind: String { UICollectionView.elementKindSectionHeader }
    
    var text: String = "" {
        didSet {
            setNeedsLayout()
            label.text = text
            self.layoutIfNeeded()
        }
    }
    
    private let label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareSubviews() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
