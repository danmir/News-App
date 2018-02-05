//
//  NewsCacheService.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation
import CoreData

protocol NewsCacheServiceProtocol: class {
    func getNews(limit: Int, completion: @escaping ([News]?, Error?) -> ())
    func saveNews(news: [News])
    
    func getNewsDetail(newsId: String, completion: @escaping (NewsDetail?, Error?) -> ())
    func saveNewsDetail(newsDetail: NewsDetail, for newsId: String)
}

class NewsCacheService: NewsCacheServiceProtocol {
    
    private let coreDataStack: CoreDataStack
    private let fetchLimit = 50
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func getNews(limit: Int, completion: @escaping ([News]?, Error?) -> ()) {
        let context = coreDataStack.mainContext
        let fetchRequest = NewsMO.fetchRequestAllNews(limit: limit)
        
        var newsMOList: [NewsMO] = []
        do {
            newsMOList = try context.fetch(fetchRequest)
        } catch let error {
            completion(nil, error)
            return
        }
        
        var newsList: [News] = []
        for newsMO in newsMOList {
            let news = NewsMO.entityToNews(newsEntity: newsMO)
            newsList.append(news)
        }
        
        completion(newsList, nil)
    }
    
    func saveNews(news: [News]) {
        let context = coreDataStack.workerContext
        
        for newsEntity in news {
            if let _ = NewsMO.fetchNews(with: newsEntity.id, in: context) {
                continue
            }
            
            if let newEntity = NewsMO.insertNews(with: newsEntity.id, in: context) {
                newEntity.publicationDate = newsEntity.publicationDate as NSDate
                newEntity.text = newsEntity.text
            }
        }
        
        _ = coreDataStack.performSave(in: context)
    }
    
    func getNewsDetail(newsId: String, completion: @escaping (NewsDetail?, Error?) -> ()) {
        let context = coreDataStack.mainContext
        
        guard let newsDetailMO = NewsDetailMO.fetchNewsDetail(by: newsId, in: context) else {
            return completion(nil, makeError(with: "Detail news wasn't found"))
        }
        let newsDetail = NewsDetailMO.entityToNewsDetail(newsDetailEntity: newsDetailMO)
        
        completion(newsDetail, nil)
    }
    
    func saveNewsDetail(newsDetail: NewsDetail, for newsId: String) {
        let context = coreDataStack.workerContext
        
        guard let newsMO = NewsMO.fetchNews(with: newsId, in: context) else {
            return
        }
        
        if let newsDetailEntity = NewsDetailMO.insertNewsDetail(in: context) {
            newsDetailEntity.content = newsDetail.content
            newsMO.content = newsDetailEntity
        }
        
        _ = coreDataStack.performSave(in: context)
    }
}
