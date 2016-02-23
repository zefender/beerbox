//
//  CoreDataDataSource.swift
//  VirtualTourist
//
//  Created by Кузяев Максим on 16.01.16.
//  Copyright © 2016 zefender. All rights reserved.
//

import CoreData
import MapKit

enum PinKeys: String {
    case Identifier = "identifier"
    case Latitude = "latitude"
    case Longitude = "longitude"
}

class CoreDataDataSource {
    private let managedObjectContext: NSManagedObjectContext
    
    init() {
        guard let modelURL = NSBundle.mainBundle().URLForResource("VirtualTouristDataModel", withExtension:"momd") else {
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
        let docURL = urls[urls.endIndex-1]
        
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
    
    func deletePhotos(pin: Pin) {
        if let photos = pin.photos {
            for photo in photos {
                managedObjectContext.deleteObject(photo as! NSManagedObject)
            }
            saveContext()
        }
    }
    
    func getPins() -> [Pin]? {
        let fetchRequest = NSFetchRequest(entityName: "Pin")
        
        do {
            let pins = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Pin]
            return pins
        } catch {
            print(error)
        }
        
        return nil
    }

    func addPhoto(flickrPhoto: FlickrPhoto, forPin pin: Pin) {
        let photo = NSEntityDescription.insertNewObjectForEntityForName("Photo", inManagedObjectContext: managedObjectContext)
        photo.setValue(flickrPhoto.title, forKey: "title")
        photo.setValue(flickrPhoto.photoId, forKey: "photoId")
        photo.setValue(flickrPhoto.server, forKey: "server")
        photo.setValue(flickrPhoto.secret, forKey: "secret")
        photo.setValue(flickrPhoto.farm, forKey: "farm")
        photo.setValue(pin, forKey: "pin")
        photo.setValue(NSUUID().UUIDString, forKey: "identifier")

        saveContext()
    }
    
    func addPinWithLongitude(longitude: Double, latitude: Double) -> Pin {
        let pin = NSEntityDescription.insertNewObjectForEntityForName("Pin", inManagedObjectContext: managedObjectContext)
        pin.setValue(longitude, forKey: PinKeys.Longitude.rawValue)
        pin.setValue(latitude, forKey: PinKeys.Latitude.rawValue)
        pin.setValue(NSUUID().UUIDString, forKey: PinKeys.Identifier.rawValue)
        
        saveContext()
        
        return pin as! Pin
    }
    
    func deletePin(pin: Pin) {
        managedObjectContext.deleteObject(pin)
        saveContext()
    }

    func deletePhoto(photo: Photo) {
        managedObjectContext.deleteObject(photo)

        saveContext()
    }
    
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}