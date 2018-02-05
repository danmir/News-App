//
//  MainFlowCoordinator.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation
import UIKit

class NewsFlowCoordinator: BaseFlowProtocol {
    
    weak var navigationController: UINavigationController?
    private let newsService: NewsServiceProtocol
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
    
    func launchViewController() -> UIViewController? {
        navigationController = UINavigationController(rootViewController: newsScreenViewController())
        return navigationController
    }
    
    func newsScreenViewController() -> NewsListScreenViewController {
        return NewsListScreenInitializer.newsListViewController(moduleOutput: self, newsService: newsService)
    }
    
    func newsDetailScreenViewController(newsId: String) -> NewsDetailScreenViewController {
        return NewsDetailScreenInitializer.newsDetailViewController(moduleOutput: self, newsService: newsService, newsId: newsId)
    }
}

extension NewsFlowCoordinator: NewsListScreenModuleOutput {
    
    func goToNewsDetailScreen(newsId: String) {
        if let navigationController = navigationController {
            navigationController.pushViewController(newsDetailScreenViewController(newsId: newsId), animated: true)
        }
    }
}

extension NewsFlowCoordinator: NewsDetailScreenModuleOutput {
    
}
