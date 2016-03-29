import Foundation

class SearchRequest: Request {
    private let term: String

    init(term: String) {
        self.term = term
    }


    override func httpMethod() -> HTTPMethod {
        return .GET
    }

    override func method() -> String {
        return "search/beer"
    }

    override func queryString() -> String {
        return "q=\(term)"
    }
}
