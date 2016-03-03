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

    func addBeerToStash(beer: BeerItem, completion: (Error) -> ()) {
        self.coreDataSource.addBeerToStash(beer)

        if !coreDataSource.breweryIsStored(beer.breweryId) {
            // load and save the brewery
//            DataManager.fetchBreweryWithId(breweryId: String) {
//
//            }

        }

        loadPhotoForUrl(beer.labelImageUrl) {
            image, error in

            if let image = image {
                if let data = UIImagePNGRepresentation(image) {
                    self.imageStorage.storeImageData(data, withFileName: String(beer.bid))
                }
            }

            completion(error)
        }
    }

    private func fetchBreweryWithId(breweryId: String, completion: (BreweryItem, Error) -> ()) {


    }


    func fetchStash() -> [BeerItem]? {
        if let stash = coreDataSource.stash() as [Beer]? {
            return stash.map {
                beer in
                return BeerItem(bid: Int(beer.bid ?? 0), name: beer.name ?? "", labelImageUrl: beer.labelImageUrl ?? "",
                        ABV: Int(beer.abv ?? 0), IBU: Int(beer.ibu ?? 0), descr: beer.descr ?? "", style: beer.style ?? "",
                breweryId: beer.breweryId)
            }
        } else {
            return nil
        }
    }

    func photoForBeer(beer: BeerItem) -> UIImage? {
        if let image = imageStorage.fetchImageWithFileName(String(beer.bid)) {
            return image
        }
        else {
            return nil
        }
    }

    func removeBeerFromStash(beer: BeerItem) {
        imageStorage.deletePhoto(String(beer.bid))
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
