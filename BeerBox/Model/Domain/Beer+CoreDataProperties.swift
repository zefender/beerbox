//
//  Beer+CoreDataProperties.swift
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

extension Beer {

    @NSManaged var abv: NSNumber?
    @NSManaged var bid: NSNumber?
    @NSManaged var descr: String?
    @NSManaged var ibu: NSNumber?
    @NSManaged var labelImageUrl: String?
    @NSManaged var name: String?
    @NSManaged var style: String?
    @NSManaged var brewery: Brewery?

}
