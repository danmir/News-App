//
//  NewsDetailScreenInitializer.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation

class NewsDetailScreenInitializer {
    
    class func newsDetailViewController(moduleOutput: NewsDetailScreenModuleOutput, newsService: NewsServiceProtocol, newsId: String) -> NewsDetailScreenViewController {
        let vc = NewsDetailScreenViewController(nibName: "NewsDetailScreenView", bundle: nil)
        
        let presenter = NewsDetailScreenPresenter<NewsDetailScreenViewController>(newsService: newsService, newsId: newsId)
        presenter.viewInput = vc
        presenter.moduleOutput = moduleOutput
        
        vc.viewOutput = presenter
        
        return vc
    }
}
