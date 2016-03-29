//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation

class BeerListParser: Parser {
    override func scanObject(parsedJson: [String:AnyObject]) -> Any? {
        var beerListModel = [BeerItem]()

        if let response = parsedJson["response"] {
            if let beers = response["beers"] as? NSDictionary {
                if let items = beers["items"] as? NSArray {
                    for item in items as NSArray {
                        var breweryId = 0

                        if let brewery = item["brewery"] as? NSDictionary {
                            breweryId = Int(brewery["brewery_id"] as? Int ?? 0)
                        }

                        let beer = item["beer"] as! NSDictionary

                        beerListModel.append(BeerItem(bid: Int(beer["bid"] as? Int ?? 0), name: String(beer["beer_name"]!),
                                labelImageUrl: String(beer["beer_label"]!), ABV: Int(beer["beer_abv"] as? Int ?? 0),
                                IBU: Int(beer["beer_ibu"] as? Int ?? 0), descr: String(beer["beer_description"]!),
                                style: String(beer["beer_style"]!), breweryId: breweryId, inStash: false))
                    }
                }

            }
        }

        return beerListModel
    }
}
