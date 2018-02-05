//
//  AppCoordinator.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation
import UIKit

class AppFlowCoordinator: BaseFlowProtocol {
    
    private let newsService: NewsServiceProtocol = {
        let newsNetworkService = NewsNetworkService()
        let coreDataStack = CoreDataStack()
        let newsCacheService = NewsCacheService(coreDataStack: coreDataStack)
        return NewsService(newsNetworkService: newsNetworkService, newsCacheService: newsCacheService)
    }()
    
    func launchViewController() -> UIViewController? {
        let newsFlowCoordinator = NewsFlowCoordinator(newsService: newsService)
        return newsFlowCoordinator.launchViewController()
    }
}
