import Foundation
import UIKit

extension CategoryListViewController {
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let item = data[indexPath.item]
        navigationController?.pushViewController(BookDetailsViewController(volume: item), animated: true)
        return false
    }
}
