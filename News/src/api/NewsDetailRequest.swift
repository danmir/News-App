//
//  NewsDetailRequest.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation

class NewsDetailRequest: BaseRequest {
    
    init(id: String) {
        super.init()
        
        parameters = parameters.merging([
            "id": id
            ], uniquingKeysWith: { (first, _) in first })
        path = "news_content/"
    }
    
    func fetchDetailNews(_ completion: @escaping (NewsDetail?, Error?) -> Void) {
        request { (json, error) in
            if let error = error {
                return completion(nil, error)
            }
            
            guard let json = json,
                let payload = json["payload"] as? [String : Any],
                let content = payload["content"] as? String
            else {
                return completion(nil, makeError(with: "Can't read server responce"))
            }
            
            completion(NewsDetail(content: content), nil)
        }
    }
}
