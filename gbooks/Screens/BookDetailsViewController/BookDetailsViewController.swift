import Foundation
import UIKit

class BookDetailsViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    var volume: Volume?

    private var dataSource: DataSource!
    
    var volumeTask: Task<Volume?, Error>?
    
    init(volume: Volume) {
        self.volume = volume
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        listConfiguration.headerMode = .firstItemInSection
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
    }
    
    init(volumeTask: Task<Volume?, Error>) {
        self.volumeTask = volumeTask
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        listConfiguration.headerMode = .firstItemInSection
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration {
            [weak self] (cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) in
                let section = self?.section(for: indexPath)
                switch (section, row) {
                case (_, .header(let title)):
                    cell.contentConfiguration = self?.headerConfiguration(for: cell, with: title)
                case (.cover, .image):
                    cell.contentConfiguration = self?.coverImageConfiguration(for: cell, with: self?.volume?.volumeInfo?.imageLinks?.thumbnail ?? self?.volume?.volumeInfo?.imageLinks?.smallThumbnail)
                case (.publishDetails, .publisherView):
                    cell.contentConfiguration = self?.textViewConfiguration(for: cell, with: self?.volume?.volumeInfo?.publisher)
                case (.publishDetails, .publishDateView):
                    cell.contentConfiguration = self?.textViewConfiguration(for: cell, with: self?.volume?.volumeInfo?.publishedDate)
                case (.title, .titleView):
                    cell.contentConfiguration = self?.textViewConfiguration(for: cell, with: self?.volume?.volumeInfo?.title)
                case (.subtitle, .subtitleView):
                    cell.contentConfiguration = self?.textViewConfiguration(for: cell, with: self?.volume?.volumeInfo?.subtitle)
                case (.authors, .author(let author)):
                    cell.contentConfiguration = self?.textViewConfiguration(for: cell, with: author)
                case (.description, .descriptionView):
                    cell.contentConfiguration = self?.textViewConfiguration(for: cell, with: self?.volume?.volumeInfo?.description)
                default:
                    fatalError("Unexpected combination of section and row.")
                }
        }
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
                    return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        navigationItem.title = NSLocalizedString("Book Details", comment: "Book Details view controller title")
        Task(priority: .background) {
            updateSnapshot()
            
            if volume == nil, let volumeTask = volumeTask {
                do {
                    
                    let result = try await volumeTask.value
                    volume = result
                    updateSnapshot()
                } catch {
                    print("VolumeTask failed in BookDetailsViewController")
                    print(error)
                }
            }
        }
    }
    
    private func updateSnapshot() {
        var snapshot = Snapshot()
        if volume != nil {
            snapshot.appendSections([.cover, .title, .subtitle, .authors, .publishDetails, .description])
            if (volume?.volumeInfo?.imageLinks?.thumbnail != nil) {
                snapshot.appendItems([.header(""),.image], toSection: .cover)
            }
            snapshot.appendItems([.header(Section.title.name), .titleView], toSection: .title)
            if (volume?.volumeInfo?.subtitle != nil) {
                snapshot.appendItems([.header(Section.subtitle.name), .subtitleView], toSection: .subtitle)
            }
            snapshot.appendItems([.header(Section.authors.name)], toSection: .authors)
            snapshot.appendItems(volume?.volumeInfo?.authors?.map { .author($0) } ?? [], toSection: .authors)
            snapshot.appendItems([.header(Section.publishDetails.name), .publisherView, .publishDateView], toSection: .publishDetails)
            snapshot.appendItems([.header(Section.description.name), .descriptionView], toSection: .description)
        }
        dataSource.apply(snapshot)
    }
    
   
    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}
