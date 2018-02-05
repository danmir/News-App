//
//  NewsListScreenPresenter.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation

class NewsListScreenPresenter<ViewInput: NewsListScreenViewInput> {
    
    var moduleOutput: NewsListScreenModuleOutput!
    weak var viewInput: ViewInput?
    private let newsService: NewsServiceProtocol
    
    private let pageSize = 50
    private var first = 0
    private var last = 0
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
        first = pageSize
        last = first + pageSize
    }
}

extension NewsListScreenPresenter: NewsListScreenModuleInput {
    
}

extension NewsListScreenPresenter: NewsListScreenViewOutput {
    
    func getNews() {
        newsService.getNews(first: 0, last: 50) { (news: [News]?, error: Error?) in
            if let news = news {
                self.viewInput?.updateDataSource(with: news)
            } else {
                self.viewInput?.show(error: error!)
            }
        }
    }
    
    func goToNewsDetailScreen(newsId: String) {
        moduleOutput.goToNewsDetailScreen(newsId: newsId)
    }
    
    func loadUpNews() {
        newsService.getNews(first: first, last: last) { (news: [News]?, error: Error?) in
            if let news = news {
                self.viewInput?.updateDataSource(with: news)
                self.first += self.pageSize
                self.last += self.pageSize
            } else {
                self.viewInput?.show(error: error!)
            }
        }
    }
}
