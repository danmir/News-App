//
//  NewsListRequest.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation

class NewsListRequest: BaseRequest {
    
    init(first: Int, last: Int) {
        super.init()
        
        parameters = parameters.merging([
            "first": String(first),
            "last": String(last)
            ], uniquingKeysWith: { (first, _) in first })
        path = "news/"
    }
    
    func fetchNews(_ completion: @escaping ([News]?, Error?) -> Void) {
        request { (json, error) in
            if let error = error {
                return completion(nil, error)
            }
            
            guard let json = json, let payload = json["payload"] as? [[String : Any]] else {
                return completion(nil, makeError(with: "Can't read server responce"))
            }
            
            var news: [News] = []
            
            for newsEntity in payload {
                guard let id = newsEntity["id"] as? String,
                    let text = newsEntity["text"] as? String,
                    let publicationDate = newsEntity["publicationDate"] as? [String: Int],
                    let milliseconds = publicationDate["milliseconds"]
                    else {
                        continue
                    }
                
                let date = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
                
                news.append(News(id: id, publicationDate: date, text: text))
            }
            
            completion(news, nil)
        }
    }
}
