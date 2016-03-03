import Foundation

class BeerRequest: Request {
    private let bid: String

    init(bid: String) {
        self.bid = bid
    }

    override func httpMethod() -> HTTPMethod {
        return HTTPMethod.GET
    }

    override func method() -> String {
        return "beer/info/"
    }

    override func path() -> String {
        return bid
    }
}
