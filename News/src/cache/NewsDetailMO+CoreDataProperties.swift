//
//  NewsDetailMO+CoreDataProperties.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//
//

import Foundation
import CoreData


extension NewsDetailMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsDetailMO> {
        return NSFetchRequest<NewsDetailMO>(entityName: entityName)
    }

    @NSManaged public var content: String
    @NSManaged public var news: NewsMO?

}
