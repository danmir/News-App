//
//  NewsMO+CoreDataClass.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//
//

import Foundation
import CoreData


public class NewsMO: NSManagedObject {

    static let entityName = "NewsMO"
    
    static func entityToNews(newsEntity: NewsMO) -> News {
        return News(id: newsEntity.id, publicationDate: newsEntity.publicationDate as Date, text: newsEntity.text)
    }
    
    static func fetchRequestAllNews(limit: Int) -> NSFetchRequest<NewsMO> {
        let fetchRequest: NSFetchRequest<NewsMO> = NSFetchRequest(entityName: entityName)
        fetchRequest.fetchLimit = limit
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "publicationDate", ascending: false)]
        return fetchRequest
    }
    
    static func fetchRequestNews(with id: String) -> NSFetchRequest<NewsMO> {
        let predicate = NSPredicate(format: "id == %@", id)
        let fetchRequest: NSFetchRequest<NewsMO> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicate
        return fetchRequest
    }
    
    static func fetchNews(with id: String, in context: NSManagedObjectContext) -> NewsMO? {
        let fetchRequest = NewsMO.fetchRequestNews(with: id)
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            return nil
        }
    }
    
    static func insertNews(with id: String, in context: NSManagedObjectContext) -> NewsMO? {
        if let newsMO = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? NewsMO {
            newsMO.id = id
            return newsMO
        }
        return nil
    }
    
}
