//
// Created by Кузяев Максим on 21.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation

class BeerListParser: Parser {
    override func scanObject(parsedJson: [String:AnyObject]) -> Any? {
        var beerListModel = BeerList(found: 0, beers: nil)

        if let found = parsedJson["found"] as? Int {
            beerListModel.found = found
        }

        if let beers = parsedJson["beers"] {
            if let items = beers["items"] as! NSArray? {
                var beerList = [BeerItem]()

                for item in items {
                    let beer = item["beer"] as! NSDictionary

                    beerList.append(BeerItem(bid: Int(beer["bid"] as? Int ?? 0), name: String(beer["beer_name"]!),
                            labelImageUrl: String(beer["beer_label"]!), ABV: Int(beer["beer_abv"] as? Int ?? 0),
                            IBU: Int(beer["beer_ibu"] as? Int ?? 0), descr: String(beer["beer_description"]!),
                            style: String(beer["beer_style"]!), breweryId: 1))
                }

                beerListModel.beers = beerList
            }
        }

        return beerListModel
    }

}
