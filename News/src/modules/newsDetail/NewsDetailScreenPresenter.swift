//
//  NewsDetailScreenPresenter.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation

class NewsDetailScreenPresenter<ViewInput: NewsDetailScreenViewInput> {
    
    var moduleOutput: NewsDetailScreenModuleOutput!
    weak var viewInput: ViewInput?
    private let newsService: NewsServiceProtocol
    private let newsId: String
    
    init(newsService: NewsServiceProtocol, newsId: String) {
        self.newsService = newsService
        self.newsId = newsId
    }
}

extension NewsDetailScreenPresenter: NewsDetailScreenModuleInput {
    
}


extension NewsDetailScreenPresenter: NewsDetailScreenViewOutput {
    
    func getDetailNews() {
        newsService.getDetailNews(with: newsId) { (newsDetail: NewsDetail?, error: Error?) in
            if let newsDetail = newsDetail {
                self.viewInput?.updateDataSource(with: newsDetail)
            } else {
                self.viewInput?.show(error: makeError(with: "Can't get detail content"))
            }
        }
    }
    
}
