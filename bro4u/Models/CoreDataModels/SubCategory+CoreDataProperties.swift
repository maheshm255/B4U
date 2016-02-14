//
//  SubCategory+CoreDataProperties.swift
//  bro4u
//
//  Created by Tools Team India on 08/02/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SubCategory {

    @NSManaged var iconName: String?
    @NSManaged var iconUrl: String?
    @NSManaged var subCategoryName: String?
    @NSManaged var category: Category?

}
