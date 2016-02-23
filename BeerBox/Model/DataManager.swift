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

    func addBeerToStash(beer: BeerItemResponse) {
        coreDataSource.addBeerToStash(beer)
    }


    func searchBeersWithTerm(term: String, completionHandler: ([Beer]?, Error) -> ()) {
        if let path = NSBundle.mainBundle().pathForResource("beers", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let parsed = BeerListParser(data: jsonData).parse() as! BeerListResponse

                var beers = [Beer]()

                if let parsedBeers = parsed.beers {
                    for beer in parsedBeers {
                        beers.append(coreDataSource.beerWithBeerResponseModel(beer))
                    }
                }

                completionHandler(beers, Error(error: nil))
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
