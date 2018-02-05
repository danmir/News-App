//
//  NewsMO+CoreDataProperties.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//
//

import Foundation
import CoreData


extension NewsMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsMO> {
        return NSFetchRequest<NewsMO>(entityName: entityName)
    }

    @NSManaged public var id: String
    @NSManaged public var publicationDate: NSDate
    @NSManaged public var text: String
    @NSManaged public var content: NewsDetailMO?

}
