import UIKit
import Foundation

extension BookSearchViewController {
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
                widthDimension: .fractionalWidth(0.45),
                heightDimension: .fractionalWidth(0.6)
            )
        )
        item1.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: .fixed(5),
            top: .fixed(5),
            trailing: .fixed(10),
            bottom: .fixed(60)
        )
        let item2 = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.45),
                heightDimension: .fractionalWidth(0.6)
            )
        )
        item2.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: .fixed(1),
            top: .fixed(60),
            trailing: .fixed(5),
            bottom: .fixed(5)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(210)
            ),
            subitems: [item1, item2]
        )
        group.interItemSpacing = .flexible(2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        return section
    }
}
