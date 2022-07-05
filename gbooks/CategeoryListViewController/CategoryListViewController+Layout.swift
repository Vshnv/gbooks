import UIKit
import Foundation

extension CategoryListViewController {
    internal static func createRootCollectionLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: compositionalLayoutSectionProvider
        )
        let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(0.2))
        
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: footerSize,
                        elementKind: ActivityIndicatorReusableView.elementKind,
                        alignment: .bottom
        )
        footer.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        layoutConfiguration.boundarySupplementaryItems = [footer]
        layout.configuration = layoutConfiguration
        return layout
    }
    
    private static func compositionalLayoutSectionProvider(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let item1 = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.33),
                heightDimension: .fractionalWidth(0.5)
            )
        )
        
        let item2 = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.33),
                heightDimension: .fractionalWidth(0.5)
            )
        )
        
        let item3 = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.33),
                heightDimension: .fractionalWidth(0.5)
            )
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(210)
            ),
            subitems: [item1, item2, item3]
        )
        group.interItemSpacing = .flexible(2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 2
        return section
    }
}
