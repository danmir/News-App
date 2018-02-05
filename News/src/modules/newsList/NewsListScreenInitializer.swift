//
//  NewsListScreenInitializer.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation

class NewsListScreenInitializer {
    
    class func newsListViewController(moduleOutput: NewsListScreenModuleOutput, newsService: NewsServiceProtocol) -> NewsListScreenViewController {
        let vc = NewsListScreenViewController(nibName: "NewsListScreenView", bundle: nil)
        
        let presenter = NewsListScreenPresenter<NewsListScreenViewController>(newsService: newsService)
        presenter.viewInput = vc
        presenter.moduleOutput = moduleOutput
        
        vc.viewOutput = presenter
        
        return vc
    }
}
