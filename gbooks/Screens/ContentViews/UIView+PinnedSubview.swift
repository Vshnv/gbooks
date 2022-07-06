import Foundation
import UIKit

extension UIView {
    func addPinnedSubview(_ subview: UIView, height: CGFloat? = nil, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1 * insets.right),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1 * insets.bottom)
        ])
        if let height = height {
            NSLayoutConstraint.activate([
                subview.heightAnchor.constraint(equalToConstant: height)
            ])
        }
    }
}
