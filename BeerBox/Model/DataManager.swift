//
// Created by Кузяев Максим on 23.02.16.
// Copyright (c) 2016 zefender. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    static let instance = DataManager()

    private let coreDataSource = CoreDataDataSource()
    private let apiClient = APIClient()
    private let imageStorage = ImageDataManager()

    func addBeerToStash(beer: BeerItem) {
        coreDataSource.addBeerToStash(beer)
    }


    func fetchStash() -> [BeerItem]? {
        if let stash = coreDataSource.stash() as [Beer]? {
            return stash.map { beer in
                return BeerItem(bid: Int(beer.bid ?? 0), name: beer.name ?? "", labelImageUrl: beer.labelImageUrl ?? "",
                        ABV: Int(beer.abv ?? 0), IBU: Int(beer.ibu ?? 0), descr: beer.descr ?? "", style: beer.style ?? "")
            }
        } else {
            return nil
        }
    }


    func removeBeerFromStash(beer: BeerItem) {
        coreDataSource.removeBeer(beer)
    }

    func searchBeersWithTerm(term: String, completionHandler: ([BeerItem]?, Error) -> ()) {
        if let path = NSBundle.mainBundle().pathForResource("beers", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let parsed = BeerListParser(data: jsonData).parse() as! BeerList

                completionHandler(parsed.beers, Error(error: nil))
            } catch {
            }
        }
    }

    func loadPhotoForUrl(urlString: String, completionHandler: (UIImage?, Error) -> ()) {
        if let url = NSURL(string: urlString) {
            apiClient.loadWithUrl(url, completionHandler: {
                (data, error) -> Void in
                var image: UIImage? = nil

                if let data = data {
                    image = UIImage(data: data)
                }

                completionHandler(image, error)
            })
        }
    }
}
