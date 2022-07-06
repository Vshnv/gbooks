import Foundation
import UIKit

extension BookSearchViewController {
    

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard case .results(let data, _) = searchState else {
            return false
        }
        
        let item = data[indexPath.item]
        navigationController?.pushViewController(BookDetailsViewController(volume: item), animated: true)

        return false
    }
}
