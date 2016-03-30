import Foundation

enum SortBy: String {
    case ByDate = "Date added"
    case ByName = "Name"
}

struct Settings {
    var sortType: SortBy
}
