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
    
    func loadPullRequestsList() {
        if repo != nil {
            view.showRepoDetail(repo: RepoDisplayData(from: repo))
            interactor.listPullRequests(for: repo)
        } else {
            print("failed to receive repo")
        }
    }
}

extension RepoPullRequestsPresenter: RepoPullRequestsInteractorOutput {
    func pullRequestsListed(pullRequests: [PullRequest]) {
        let pullRequestsDisplayData = pullRequests.map { (pullRequest) -> PullRequestDisplayData in
            return PullRequestDisplayData(from: pullRequest)
        }
        view.showPullRequests(pullRequestsDisplayData)
    }
    
    func failedToListPullRequests() {
        view.showNoContent()
    }
}
