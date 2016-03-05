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

    func addBeerToStash(beerId: Int, completion: (Error) -> ()) {
        // load beer's details
        fetchBeerWithId(beerId) {
            fetchedBeer, error in
            if let beer = fetchedBeer {
                // Do we have brewery for beer?
                if !self.coreDataSource.breweryIsStored(beer.bid) {
                    // load and save the brewery
                    self.fetchBreweryWithId(beer.breweryId) {
                        brewery, error in
                        if let brewery = brewery {
                            // save to local store
                            self.coreDataSource.addBrewery(brewery)

                            // save beer to local store
                            self.coreDataSource.addBeerToStash(beer)
                        }
                    }

                    // save beer to local store
                    self.coreDataSource.addBeerToStash(beer)
                }
            }
        }
    }


    private func fetchBreweryWithId(breweryId: Int, completion: (BreweryItem?, Error) -> ()) {
        let request = BreweryRequest(breweryId: breweryId)

        apiClient.sendRequest(request) {
            data, error in

            if let data = data {
                if let brewery = BreweryParser(data: data).parse() as? BreweryItem {

                    // load label
                    self.loadPhotoForUrl(/*brewery.labelImageUrl*/ "") {
                        image, error in

                        if let image = image {
                            if let data = UIImagePNGRepresentation(image) {
                                self.imageStorage.storeImageData(data, withFileName: String(brewery.bid))
                            }
                        }

                        completion(brewery, error)
                    }
                }
            } else {
                completion(nil, error)
            }
        }
    }

    private func fetchBeerWithId(beerId: Int, completion: (BeerItem?, Error) -> ()) {
        let request = BeerRequest(bid: beerId)

        apiClient.sendRequest(request) {
            data, error in

            print(NSString(data: data!, encoding: NSUTF8StringEncoding))

            if let data = data {
                if let beer = BeerParser(data: data).parse() as? BeerItem {

                    // load label
                    self.loadPhotoForUrl(/*brewery.labelImageUrl*/ "") {
                        image, error in

                        if let image = image {
                            if let data = UIImagePNGRepresentation(image) {
                                self.imageStorage.storeImageData(data, withFileName: String(beer.bid))
                            }
                        }

                        completion(beer, error)
                    }
                }
            } else {
                completion(nil, error)
            }
        }
    }


    func fetchStash() -> [BeerItem]? {
        if let stash = coreDataSource.stash() as [Beer]? {
            return stash.map {
                beer in
                return BeerItem(bid: Int(beer.bid ?? 0), name: beer.name ?? "", labelImageUrl: beer.labelImageUrl ?? "",
                        ABV: Int(beer.abv ?? 0), IBU: Int(beer.ibu ?? 0), descr: beer.descr ?? "", style: beer.style ?? "",
                        breweryId: 1 /*beer.breweryId*/, inStash: true)
            }
        } else {
            return nil
        }
    }

    func photoForBeer(beer: BeerItem) -> UIImage? {
        if let image = imageStorage.fetchImageWithFileName(String(beer.bid)) {
            return image
        } else {
            return nil
        }
    }

    func removeBeerFromStash(beer: BeerItem) {
        imageStorage.deletePhoto(String(beer.bid))
        coreDataSource.removeBeer(beer)

        // remove brewery if it was last beer
        if let brewery = coreDataSource.breweryById(beer.breweryId) {
            if brewery.beersInStash == 0 {
                coreDataSource.removeBreweryById(brewery.bid)
            }
        }
    }

    func searchBeersWithTerm(term: String, completionHandler: ([BeerItem]?, Error) -> ()) {
        if let path = NSBundle.mainBundle().pathForResource("beers", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let parsed = BeerListParser(data: jsonData).parse() as! BeerList

                // set inStash
                if let beers = parsed.beers {
                    for var beer in beers {
                        beer.inStash = coreDataSource.beerIsStashed(beer.bid)
                    }
                }

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
