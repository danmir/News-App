//
//  NewsListScreen.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation

protocol NewsListScreenModuleInput: BaseModuleInput {
}

protocol NewsListScreenModuleOutput: BaseModuleOutput {
    func goToNewsDetailScreen(newsId: String)
}

protocol NewsListScreenViewInput: BaseViewInput {
    func updateDataSource(with news: [News])
}

protocol NewsListScreenViewOutput: BaseViewOutput {
    func getNews()
    func goToNewsDetailScreen(newsId: String)
    func loadUpNews()
}
