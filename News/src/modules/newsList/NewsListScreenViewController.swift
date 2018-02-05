//
//  NewsListScreenViewController.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation
import UIKit

class NewsListScreenViewController: UIViewController {
    
    var viewOutput: NewsListScreenViewOutput?
    @IBOutlet weak var tableView: UITableView!
    var refresher: UIRefreshControl!
    
    private var dataSource: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
        configureRefresher()
        
        viewOutput?.getNews()
    }
    
    private func configureView() {
        navigationItem.title = "Tinkoff News"
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "\(NewsListCell.self)", bundle: nil), forCellReuseIdentifier: "\(NewsListCell.self)")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }
    
    private func configureRefresher() {
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(self.getNews), for: UIControlEvents.valueChanged)
        tableView.addSubview(refresher)
    }
    
    @objc private func getNews() {
        viewOutput?.getNews()
    }
}

extension NewsListScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(NewsListCell.self)", for: indexPath) as! NewsListCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        let news = dataSource[indexPath.row]
        cell.publicationDateLabel.text = dateFormatter.string(from: news.publicationDate)
        cell.shortTextLabel.text = news.text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = dataSource[indexPath.row]
        
        viewOutput?.goToNewsDetailScreen(newsId: news.id)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = dataSource.count - 1
        if indexPath.row == lastItem {
            viewOutput?.loadUpNews()
        }
    }
}

extension NewsListScreenViewController: NewsListScreenViewInput  {
    typealias ViewType = NewsListScreenView
    
    func updateDataSource(with news: [News]) {
        for newsEntity in news {
            if dataSource.contains(where: { $0.id == newsEntity.id }) {
                continue
            } else {
                dataSource.append(newsEntity)
            }
        }
        
        dataSource = dataSource.sorted { $0.publicationDate > $1.publicationDate }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refresher.endRefreshing()
        }
    }
}

