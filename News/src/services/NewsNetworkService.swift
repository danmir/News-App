//
//  NewsNetworkService.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation

protocol NewsNetworkServiceProtocol: class {
    func fetchNews(first: Int, last: Int, completion: @escaping ([News]?, Error?) -> Void)
    func fetchNewsDetail(newsId: String, completion: @escaping (NewsDetail?, Error?) -> Void)
}

class NewsNetworkService: NewsNetworkServiceProtocol {
    func fetchNews(first: Int = 0, last: Int = 50, completion: @escaping ([News]?, Error?) -> Void) {
        let newsListRequest = NewsListRequest(first: first, last: last)
        newsListRequest.fetchNews { (news, error) in
            if let error = error {
                return completion(nil, error)
            }
            
            completion(news, error)
        }
    }
    
    func fetchNewsDetail(newsId: String, completion: @escaping (NewsDetail?, Error?) -> Void) {
        let newsDetailRequest = NewsDetailRequest(id: newsId)
        newsDetailRequest.fetchDetailNews { (newsDetail, error) in
            if let error = error {
                return completion(nil, error)
            }
            
            completion(newsDetail, error)
        }
    }
}
