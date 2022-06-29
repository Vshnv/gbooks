import UIKit

extension BookCategoryCollectionViewController {
    internal func createRootCollectionLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: compositionalLayoutSectionProvider
        )
        let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(0.4))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: LogoImageReusableView.elementKind,
                        alignment: .top
        )
        header.contentInsets = NSDirectionalEdgeInsets(
            top: 20,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        layoutConfiguration.boundarySupplementaryItems = [header]
        layout.configuration = layoutConfiguration
        return layout
    }
    
    private func compositionalLayoutSectionProvider(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch Section(rawValue: sectionIndex) {
        case .bestSellersScience:
            fallthrough
        case .bestSellersFiction:
            return createBestSellerSection()
        case .thriller:
            fallthrough
        case .manga:
            fallthrough
        case .sports:
            fallthrough
        case .fiction:
            return createCategorySection()
        default:
            fatalError("Unknown section inserted")
        }
    }
    
    private func createBestSellerSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(150)
            )
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(150)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 0,
            bottom: 5,
            trailing: 0
        )
        section.orthogonalScrollingBehavior = .paging
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: HeadingLabelReusableView.elementKind,
                        alignment: .top
        )
        
        header.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )

        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(150),
                heightDimension: .estimated(200)
            )
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(150),
                heightDimension: .estimated(200)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        section.orthogonalScrollingBehavior = .continuous
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: HeadingLabelReusableView.elementKind,
                        alignment: .top
        )
    

        section.boundarySupplementaryItems = [header]
        return section
    }
}
