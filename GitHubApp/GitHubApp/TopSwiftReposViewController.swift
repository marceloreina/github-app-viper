//
//  TopSwiftReposViewController.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 02/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit

class TopSwiftReposViewController: UIViewController {

    var presenter: TopSwiftReposPresentation!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    weak var refreshControl: UIRefreshControl!
    
    var topSwiftRepoList: [RepoDisplayData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    
    private func setupView() {
        title = "Swift Repos"
        
        //setup navigation bar
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(colorLiteralRed: 27/255.0, green: 31/255.0, blue: 35/255.0, alpha: 1)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(colorLiteralRed: 188/255.0, green: 189/255.0, blue: 192/255.0, alpha: 1)]
        
        //setup tableview
        tableView.dataSource = self
        tableView.delegate = self
        
        //hide no data view
        noDataView.isHidden = true
        
        //create refresh control
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(TopSwiftReposViewController.refreshAction(sender:)), for: .valueChanged)
        tableView.addSubview(refresh)
        
    }
    
    @objc private func refreshAction(sender: UIRefreshControl) {
        presenter.reloadReposList()
        refreshControl = sender
    }
}

extension TopSwiftReposViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = topSwiftRepoList {
            return list.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell") as? RepoTableViewCell
        
        let repoData = topSwiftRepoList![indexPath.row]
        cell?.setupCell(data: repoData)
        
        return cell!
    }
}

extension TopSwiftReposViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.repoSelected(at: indexPath.row)
    }
}

extension TopSwiftReposViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset + scrollViewHeight == scrollContentSizeHeight
        {
            presenter.loadMoreRepos()
        }
    }
}

extension TopSwiftReposViewController: TopSwiftReposView {
    func showRepos(repos: [RepoDisplayData]) {
        if let refresh = refreshControl {
            refresh.endRefreshing()
            refreshControl = nil
        }
        noDataView.isHidden = true
        topSwiftRepoList = repos
        tableView.reloadData()
    }
    
    func showNoContent() {
        noDataView.isHidden = false
    }    
}
