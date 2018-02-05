//
//  NewsDetailScreenViewController.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation
import UIKit

class NewsDetailScreenViewController: UIViewController {
    
    @IBOutlet weak var contentView: UITextView!
    
    var viewOutput: NewsDetailScreenViewOutput?
    private var data: NewsDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewOutput?.getDetailNews()
    }
    
}

extension NewsDetailScreenViewController: NewsDetailScreenViewInput  {
    typealias ViewType = NewsDetailScreenView
    
    func updateDataSource(with newsDetail: NewsDetail) {
        data = newsDetail
        
        if let data = data, let content = data.content.html2AttributedString {
            DispatchQueue.main.async {
                self.contentView.attributedText = content
            }
        }
    }
}
