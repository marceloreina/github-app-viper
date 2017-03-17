//
//  RepoPullRequestsPresenter.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 11/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation

class RepoPullRequestsPresenter {
    weak var view: RepoPullRequestsView!
    var interactor: RepoPullRequestsUseCase!
    var router: RepoPullRequestsWireframe!
    
    var repo: Repo!
}

extension RepoPullRequestsPresenter: RepoPullRequestsPresentation {
    
    func viewDidLoad() {
        if repo != nil {
            view.showRepoTitle(text: repo.name)
        } else {
            print("failed to receive repo")
        }
    }
}

extension RepoPullRequestsPresenter: RepoPullRequestsInteractorOutput {
    
}
