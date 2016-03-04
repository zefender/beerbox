import Foundation

class BreweryRequest: Request {
    private let breweryId: Int

    init(breweryId: Int) {
        self.breweryId = breweryId
    }

    override func httpMethod() -> HTTPMethod {
        return HTTPMethod.GET
    }

    override func method() -> String {
        return "/brewery/info/"
    }

    override func path() -> String {
        return String(breweryId)
    }
}
