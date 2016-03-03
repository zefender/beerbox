import Foundation

class BreweryRequest: Request {
    private let breweryId: String

    init(breweryId: String) {
        self.breweryId = breweryId
    }

    override func httpMethod() -> HTTPMethod {
        return HTTPMethod.GET
    }

    override func method() -> String {
        return "/brewery/info/"
    }

    override func path() -> String {
        return breweryId
    }
}
