//
//  NewsDetailScreen.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation

protocol NewsDetailScreenModuleInput: BaseModuleInput {
}

protocol NewsDetailScreenModuleOutput: BaseModuleOutput {
}

protocol NewsDetailScreenViewInput: BaseViewInput {
    
    func updateDataSource(with newsDetail: NewsDetail)
}

protocol NewsDetailScreenViewOutput: BaseViewOutput {
    
    func getDetailNews()
}

