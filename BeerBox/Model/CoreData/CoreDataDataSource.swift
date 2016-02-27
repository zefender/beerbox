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
}

enum BreweryKeys: String {
    case Identifier = "identifier"
    case Latitude = "latitude"
    case Longitude = "longitude"
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

        saveContext()
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