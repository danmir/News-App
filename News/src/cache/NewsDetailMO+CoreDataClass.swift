//
//  NewsDetailMO+CoreDataClass.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//
//

import Foundation
import CoreData


public class NewsDetailMO: NSManagedObject {
    
    static let entityName = "NewsDetailMO"
    
    static func entityToNewsDetail(newsDetailEntity: NewsDetailMO) -> NewsDetail {
        return NewsDetail(content: newsDetailEntity.content)
    }
    
    static func fetchRequestNewsDetail(by newsId: String) -> NSFetchRequest<NewsDetailMO> {
        let predicate = NSPredicate(format: "news.id == %@", newsId)
        let fetchRequest: NSFetchRequest<NewsDetailMO> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicate
        return fetchRequest
    }
    
    static func insertNewsDetail(in context: NSManagedObjectContext) -> NewsDetailMO? {
        if let newsDetailMO = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? NewsDetailMO {
            return newsDetailMO
        }
        
        return nil
    }
    
    static func fetchNewsDetail(by newsId: String, in context: NSManagedObjectContext) -> NewsDetailMO? {
        let fetchRequest = NewsDetailMO.fetchRequestNewsDetail(by: newsId)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            return nil
        }
    }
}
