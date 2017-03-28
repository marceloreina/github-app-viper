//
//  RepoPullRequestsViewController.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 11/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit

class RepoPullRequestsViewController: UIViewController {

    var presenter: RepoPullRequestsPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupView()
        presenter.loadPullRequestsList()
    }

    private func setupView() {
        navigationController?.navigationItem.leftBarButtonItem?.tintColor = UIColor(colorLiteralRed: 188/255.0, green: 189/255.0, blue: 192/255.0, alpha: 1)
    }

}

extension RepoPullRequestsViewController: RepoPullRequestsView {
    
    func showRepoDetail(repo: RepoDisplayData) {
        title = repo.repoName
    }
    
    func showPullRequests(_ pullRequests: [PullRequestDisplayData]) {
        print("A VERDADEIRA FESTA: \(pullRequests)")
    }
    
    func showNoContent() {
        print("NADA A DECLARAR")
    }
        
}
