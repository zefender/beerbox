import Foundation

class BeerParser: Parser {
    override func scanObject(parsedJson: [String:AnyObject]) -> Any? {
        if let response = parsedJson["response"] {
            if let beer = response["beer"] as? NSDictionary {
                var breweryId = 0

                if let brewery = beer["brewery"] as? NSDictionary {
                     breweryId = Int(brewery["brewery_id"] as? Int ?? 0)
                }

                return BeerItem(bid: Int(beer["bid"] as? Int ?? 0), name: String(beer["beer_name"]!),
                        labelImageUrl: String(beer["beer_label"]!), ABV: Int(beer["beer_abv"] as? Int ?? 0),
                        IBU: Int(beer["beer_ibu"] as? Int ?? 0), descr: String(beer["beer_description"]!),
                        style: String(beer["beer_style"]!), breweryId: breweryId, inStash: false,
                        rating: Double(beer["rating_score"] as? Double ?? 0))
            }
        }

        return nil
    }
}
