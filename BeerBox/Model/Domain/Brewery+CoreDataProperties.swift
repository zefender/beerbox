//
//  Brewery+CoreDataProperties.swift
//  BeerBox
//
//  Created by Кузяев Максим on 27.03.16.
//  Copyright © 2016 zefender. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Brewery {

    @NSManaged var bid: NSNumber?
    @NSManaged var country: String?
    @NSManaged var imageLabelUrl: String?
    @NSManaged var lat: NSNumber?
    @NSManaged var lon: NSNumber?
    @NSManaged var name: String?
    @NSManaged var siteUrl: String?
    @NSManaged var descr: String?
    @NSManaged var address: String?
    @NSManaged var beers: NSSet?

}
