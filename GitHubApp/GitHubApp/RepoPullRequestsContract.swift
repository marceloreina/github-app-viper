//
//  RepoPullRequestsContract.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 11/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit

protocol RepoPullRequestsPresentation: class {
    func loadPullRequestsList()
}

protocol RepoPullRequestsView: class {
    func showRepoDetail(repo: RepoDisplayData)
    func showPullRequests(_ pullRequest: [PullRequestDisplayData])
    func showNoContent()
}

protocol RepoPullRequestsUseCase: class {
    func listPullRequests(for repo: Repo)
}

protocol RepoPullRequestsInteractorOutput: class {
    func pullRequestsListed(pullRequests: [PullRequest])
    func failedToListPullRequests()
}

protocol RepoPullRequestsWireframe: class {
    weak var viewController: UIViewController? { get set }
    static func createModule(for repo: Repo) -> UIViewController
}

