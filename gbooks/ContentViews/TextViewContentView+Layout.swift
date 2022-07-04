import Foundation
import UIKit

extension TextViewContentView {
    func setupLayout(textView: UITextView) {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1 * 8),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textView.heightAnchor.constraint(equalToConstant: 200)
        ])
        textView.backgroundColor = nil
        textView.delegate = self
        textView.font = UIFont.preferredFont(forTextStyle: .body)
    }
}
