//
//  CoreDataDataSource.swift
//  VirtualTourist
//
//  Created by Кузяев Максим on 16.01.16.
//  Copyright © 2016 zefender. All rights reserved.
//

import CoreData
import MapKit

enum BeerKeys: String {
    case ABV = "abv"
    case Id = "bid"
    case Descr = "descr"
    case IBU = "ibu"
    case LabelImageUrl = "labelImageUrl"
    case Name = "name"
    case Style = "style"
    case Brewery = "brewery"
    case Rating = "rating"
    case Date = "dateAdded"
}

enum BreweryKeys: String {
    case Id = "bid"
    case Latitude = "lat"
    case Longitude = "lon"
    case Country = "country"
    case Descr = "descr"
    case Name = "name"
    case Address = "address"
    case LabelImageUrl = "imageLabelUrl"
    case Rating = "rating"
}

class CoreDataDataSource {
    private let managedObjectContext: NSManagedObjectContext

    func addBeerToStash(model: BeerItem) {
        let beer = NSEntityDescription.insertNewObjectForEntityForName("Beer", inManagedObjectContext: managedObjectContext)
        beer.setValue(model.bid, forKey: BeerKeys.Id.rawValue)
        beer.setValue(model.ABV, forKey: BeerKeys.ABV.rawValue)
        beer.setValue(model.descr, forKey: BeerKeys.Descr.rawValue)
        beer.setValue(model.IBU, forKey: BeerKeys.IBU.rawValue)
        beer.setValue(model.labelImageUrl, forKey: BeerKeys.LabelImageUrl.rawValue)
        beer.setValue(model.name, forKey: BeerKeys.Name.rawValue)
        beer.setValue(model.style, forKey: BeerKeys.Style.rawValue)
        beer.setValue(model.rating, forKey: BeerKeys.Rating.rawValue)
        beer.setValue(NSDate(), forKey: BeerKeys.Date.rawValue)

        // get brewery
        if let brewery = brewery(model.breweryId) {
            beer.setValue(brewery, forKey: BeerKeys.Brewery.rawValue)
        }

        saveContext()
    }

    private func brewery(id: Int) -> Brewery? {
        let fetchRequest = NSFetchRequest(entityName: "Brewery")
        fetchRequest.predicate = NSPredicate(format: "bid == %d", id)

        do {
            if let brewers = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Brewery] {
                return brewers.first
            }
        } catch {
            print(error)
        }

        return nil
    }

    func breweryById(id: Int) -> BreweryItem? {
        if let brewery = brewery(id) {
            return BreweryItem(bid: brewery.bid!.integerValue, labelImageUrl: brewery.imageLabelUrl ?? "",
                    name: brewery.name ?? "", address: brewery.name ?? "", lon: Double(brewery.lon ?? 0),
                    lat: Double(brewery.lat ?? 0), about: brewery.descr ?? "", country: brewery.country ?? "",
                    beersInStash: brewery.beers?.count ?? 0, rating: Double(brewery.rating ?? 0))
        }

        return nil
    }


    func stash() -> [Beer]? {
        let fetchRequest = NSFetchRequest(entityName: "Beer")

        do {
            let beers = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Beer]
            return beers
        } catch {
            print(error)
        }

        return nil
    }

    func removeBeer(beer: BeerItem) {
        let fetchRequest = NSFetchRequest(entityName: "Beer")
        fetchRequest.predicate = NSPredicate(format: "bid == %d", beer.bid)

        do {
            if let beers = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Beer] {
                if let beer = beers.first {
                    managedObjectContext.deleteObject(beer)
                    saveContext()
                }
            }
        } catch {
            print(error)
        }
    }


    func addBrewery(brewery: BreweryItem) {
        let breweryMO = NSEntityDescription.insertNewObjectForEntityForName("Brewery", inManagedObjectContext: managedObjectContext)
        breweryMO.setValue(brewery.bid, forKey: BreweryKeys.Id.rawValue)
        breweryMO.setValue(brewery.country, forKey: BreweryKeys.Country.rawValue)
        breweryMO.setValue(brewery.about, forKey: BreweryKeys.Descr.rawValue)
        breweryMO.setValue(brewery.name, forKey: BreweryKeys.Name.rawValue)
        breweryMO.setValue(brewery.address, forKey: BreweryKeys.Address.rawValue)
        breweryMO.setValue(brewery.labelImageUrl, forKey: BreweryKeys.LabelImageUrl.rawValue)
        breweryMO.setValue(brewery.lat, forKey: BreweryKeys.Latitude.rawValue)
        breweryMO.setValue(brewery.lon, forKey: BreweryKeys.Longitude.rawValue)
        breweryMO.setValue(brewery.rating, forKey: BreweryKeys.Rating.rawValue)

        saveContext()
    }

    func removeBreweryById(id: Int) {
        let fetchRequest = NSFetchRequest(entityName: "Brewery")
        fetchRequest.predicate = NSPredicate(format: "bid == %d", id)

        do {
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Brewery] {
                if let item = results.first {
                    managedObjectContext.deleteObject(item)
                    saveContext()
                }
            }
        } catch {
            print(error)
        }
    }

    func breweryIsStored(breweryId: Int) -> Bool {
        let fetchRequest = NSFetchRequest(entityName: "Brewery")
        fetchRequest.predicate = NSPredicate(format: "bid == %d", breweryId)

        do {
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Brewery] {
                if let _ = results.first {
                    return true
                }
            }
        } catch {
            print(error)
        }

        return false
    }

    func beerIsStashed(beerId: Int) -> Bool {
        let fetchRequest = NSFetchRequest(entityName: "Beer")
        fetchRequest.predicate = NSPredicate(format: "bid == %d", beerId)

        do {
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Brewery] {
                if let _ = results.first {
                    return true
                }
            }
        } catch {
            print(error)
        }

        return false
    }

    init() {
        guard let modelURL = NSBundle.mainBundle().URLForResource("BeerBoxDataModel", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }

        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }

        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = psc


        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let docURL = urls[urls.endIndex - 1]

        /* The directory the application uses to store the Core Data store file.
        This code uses a file named "DataModel.sqlite" in the application's documents directory.
        */
        let storeURL = docURL.URLByAppendingPathComponent("DataModel.sqlite")

        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }


    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}