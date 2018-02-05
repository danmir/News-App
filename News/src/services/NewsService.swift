//
//  NewsService.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation

protocol NewsServiceProtocol: class {
    func getNews(first: Int, last: Int, completion: @escaping ([News]?, Error?) -> ())
    func getDetailNews(with id: String, completion: @escaping (NewsDetail?, Error?) -> ())
}

class NewsService: NewsServiceProtocol {
    
    private let newsNetworkService: NewsNetworkServiceProtocol
    private let newsCacheService: NewsCacheServiceProtocol
    
    init(newsNetworkService: NewsNetworkServiceProtocol, newsCacheService: NewsCacheServiceProtocol) {
        self.newsNetworkService = newsNetworkService
        self.newsCacheService = newsCacheService
    }
    
    func getNews(first: Int = 0, last: Int = 50, completion: @escaping ([News]?, Error?) -> ()) {
        newsCacheService.getNews(limit: 50) { (cacheNews: [News]?, error) in
            if let cacheNews = cacheNews {
                self.newsNetworkService.fetchNews(first: first, last: last) { (networkNews: [News]?, error) in
                    if let networkNews = networkNews {
                        self.newsCacheService.saveNews(news: networkNews)
                        return completion(self.mergeNews(cahceNews: cacheNews, networkNews: networkNews), nil)
                    } else {
                        return completion(cacheNews, nil)
                    }
                }
            } else {
                self.newsNetworkService.fetchNews(first: first, last: last) { (networkNews: [News]?, error) in
                    if let networkNews = networkNews {
                        self.newsCacheService.saveNews(news: networkNews)
                        return completion(networkNews, nil)
                    }
                }
            }
        }
    }
    
    func getDetailNews(with id: String, completion: @escaping (NewsDetail?, Error?) -> ()) {
        newsCacheService.getNewsDetail(newsId: id) { (cacheDetailNews: NewsDetail?, error) in
            if let cacheDetailNews = cacheDetailNews {
                self.newsNetworkService.fetchNewsDetail(newsId: id) { (networkDetailNews: NewsDetail?, error) in
                    if let networkDetailNews = networkDetailNews {
                        self.newsCacheService.saveNewsDetail(newsDetail: networkDetailNews, for: id)
                        return completion(networkDetailNews, nil)
                    } else {
                        return completion(cacheDetailNews, nil)
                    }
                }
            } else {
                self.newsNetworkService.fetchNewsDetail(newsId: id) { (networkDetailNews: NewsDetail?, error) in
                    if let networkDetailNews = networkDetailNews {
                        self.newsCacheService.saveNewsDetail(newsDetail: networkDetailNews, for: id)
                        return completion(networkDetailNews, nil)
                    } else {
                        return completion(nil, makeError(with: "No cache and can't doenload content"))
                    }
                }
            }
        }
    }
    
    func mergeNews(cahceNews: [News], networkNews: [News]) -> [News] {
        var resultNews = cahceNews
        for newsEntity in networkNews {
            if cahceNews.contains(where: { $0.id == newsEntity.id }) {
                continue
            } else {
                resultNews.append(newsEntity)
            }
        }
        return resultNews
    }
}
