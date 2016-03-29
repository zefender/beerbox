import Foundation

class BreweryParser: Parser {
    override func scanObject(parsedJson: [String:AnyObject]) -> Any? {
        if let response = parsedJson["response"] {
            if let brewery = response["brewery"] as? NSDictionary {
                let location = brewery["location"] as! NSDictionary

                return BreweryItem(bid: Int(brewery["brewery_id"] as? Int ?? 0), labelImageUrl: String(brewery["brewery_label"]!),
                        name: String(brewery["brewery_name"]!), address: String(location["brewery_address"]!),
                        lon: Double(location["brewery_lng"] as? Double ?? 0),
                        lat: Double(location["brewery_lat"] as? Double ?? 0),
                        about: String(brewery["brewery_description"]!), country: String(brewery["country_name"]!))
            }
        }

        return nil
    }
}
