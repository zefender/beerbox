import Foundation

class BeerRequest: Request {
    private let bid: Int

    init(bid: Int) {
        self.bid = bid
    }

    override func httpMethod() -> HTTPMethod {
        return .GET
    }

    override func method() -> String {
        return "beer/info/\(bid)"
    }
}
