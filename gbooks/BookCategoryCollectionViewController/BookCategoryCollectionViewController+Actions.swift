import Foundation
import UIKit

extension BookCategoryCollectionViewController {
    
    @objc func onSearchButtonPress(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(BookSearchViewController(), animated: true)
    }

}
