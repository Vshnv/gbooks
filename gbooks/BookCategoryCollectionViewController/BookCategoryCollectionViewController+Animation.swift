import UIKit

extension BookCategoryCollectionViewController {
    static let logoDisappearOffset: CGFloat = 175
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let views = collectionView.visibleSupplementaryViews(ofKind: LogoImageReusableView.elementKind)
        guard views.count > 0, let logoView = views[0] as? LogoImageReusableView else {
            return
        }
        let y = scrollView.contentOffset.y + 100
        let position = max(0, min(1, (BookCategoryCollectionViewController.logoDisappearOffset - y) / BookCategoryCollectionViewController.logoDisappearOffset))
        logoView.imageView.alpha = position
        
        if navigationItem.leftBarButtonItem == nil {
            if position < 0.01 {
                navigationItem.leftBarButtonItem = iconBarButton
            }
        } else {
            if position > 0.05 {
                navigationItem.leftBarButtonItem = nil
            }
        }
    }
}
