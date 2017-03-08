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
    
    var topSwiftRepoList: [RepoDisplayData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    
    private func setupView() {
        title = "Top Swift Repos"
        
        //setup navigation bar
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(colorLiteralRed: 27/255.0, green: 31/255.0, blue: 35/255.0, alpha: 1)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(colorLiteralRed: 188/255.0, green: 189/255.0, blue: 192/255.0, alpha: 1)]
        
        //setup tableview
        tableView.dataSource = self
        
    }
    
    static func createFromStoryboard(name: String) -> TopSwiftReposViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self))
        return viewController as! TopSwiftReposViewController
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

extension TopSwiftReposViewController: TopSwiftReposView {
    func showRepos(repos: [RepoDisplayData]) {
        topSwiftRepoList = repos
        tableView.reloadData()
    }
    
    func showNoContent() {
        print("NO CONTENT TO SHOW")
    }
    
    var currentPage: Int {
        return 0
    }
}
