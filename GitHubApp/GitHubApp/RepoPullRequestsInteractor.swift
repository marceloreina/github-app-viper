//
//  RepoPullRequestsInteractor.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 11/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation

class RepoPullRequestsInteractor: RepoPullRequestsUseCase {
    weak var output: RepoPullRequestsInteractorOutput!
    
    func listPullRequests(for repo: Repo) {
        GitHubService.listPullRequests(ownerLogin: repo.user.login, repoName: repo.name, state: "all", sortedBy: "created") { (result) in
            switch result {
            case .success(let object):
                self.output.pullRequestsListed(pullRequests: object)
            case .failure(_):
                self.output.failedToListPullRequests()
            }
        }
    }
}
