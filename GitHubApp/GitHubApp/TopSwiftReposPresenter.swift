//
//  TopSwiftReposPresenter.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 02/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation

class TopSwiftReposPresenter {
    weak var view: TopSwiftReposView!
    var interactor: TopSwiftReposUseCase!
    var router: TopSwiftReposWireframe!
    
    var repos: [Repo] = [] {
        didSet {
            if repos.count > 0 {
                view?.showRepos(repos: repos.flatMap({ (repo) -> RepoDisplayData? in
                    return RepoDisplayData(repoName: repo.name,
                                                      repoDescription: repo.repoDescription,
                                                      watchNumber: "\(repo.watchersCount)",
                        forkNumber: "\(repo.forksCount)",
                        starNumber: "\(repo.stargazersCount)",
                        ownerName: repo.user.login,
                        ownerProfileImageURL: URL(string: repo.user.avatarURL)!)
                }))
            } else {
                view?.showNoContent()
            }
        }
    }
}

extension TopSwiftReposPresenter: TopSwiftReposInteractorOutput {
    func topSwiftReposFetched(repos: [Repo]) {
        self.repos = repos
    }
    
    func failedToLoadRepos() {
        view.showNoContent()
    }
}

extension TopSwiftReposPresenter: TopSwiftReposPresentation {
    func viewDidLoad() {
        interactor.fetchTopSwiftRepos(pageNumber: view.currentPage)
    }
}
