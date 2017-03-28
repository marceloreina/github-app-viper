//
//  TopSwiftReposContract.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 02/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit

protocol TopSwiftReposPresentation: class {
    func loadRepoList()
    func loadMoreRepos()
    func repoSelected(at index: Int)
}

protocol TopSwiftReposView: class {
    func showRepos(repos: [RepoDisplayData])
    func showNoContent()
}

protocol TopSwiftReposUseCase: class {
    func fetchTopSwiftRepos(pageNumber: Int)
}

protocol TopSwiftReposInteractorOutput: class {
    func topSwiftReposFetched(repos: [Repo])
    func failedToLoadRepos()
}

protocol TopSwiftReposWireframe: class {
    weak var viewController: UIViewController? { get set }
    
    func presentRepoPullRequests(for repo: Repo)
    
    static func createModule() -> UIViewController
}
