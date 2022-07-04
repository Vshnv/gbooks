import Foundation

extension BookDetailsViewController {
    enum Section: Int, Hashable {
        case cover
        case title
        case subtitle
        case authors
        case publishDetails
        case description
        
        var name: String {
            switch self {
            case .cover:
                return NSLocalizedString("Cover", comment: "Cover section name")
            case .title:
                return NSLocalizedString("Title", comment: "Title section name")
            case .subtitle:
                return NSLocalizedString("Subtitle", comment: "Subtitle section name")
            case .authors:
                return NSLocalizedString("Authors", comment: "Authors section name")
            case .publishDetails:
                return NSLocalizedString("Publisher", comment: "Publisher section name")
            case .description:
                return NSLocalizedString("Description", comment: "Description section name")
            }
        }
    }
}
