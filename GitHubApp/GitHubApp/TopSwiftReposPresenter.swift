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
    
    static let initialPageNumber = 1
    var currentPage = TopSwiftReposPresenter.initialPageNumber
    var topSwiftRepos = [Repo]()
}

extension TopSwiftReposPresenter: TopSwiftReposInteractorOutput {
    func topSwiftReposFetched(repos: [Repo]) {
        if repos.isEmpty && topSwiftRepos.isEmpty {
            view!.showNoContent()
        } else {
            topSwiftRepos.append(contentsOf: repos)
            view?.showRepos(repos: topSwiftRepos.flatMap({ (repo) -> RepoDisplayData? in
                return RepoDisplayData(from: repo)
            }))
        }
        
    }
    
    func failedToLoadRepos() {
        view.showNoContent()
    }
}

extension TopSwiftReposPresenter: TopSwiftReposPresentation {
    func loadRepoList() {
        currentPage = TopSwiftReposPresenter.initialPageNumber
        topSwiftRepos.removeAll()
        interactor.fetchTopSwiftRepos(pageNumber: currentPage)
    }
    
    func loadMoreRepos() {
        currentPage += 1
        interactor.fetchTopSwiftRepos(pageNumber: currentPage)
    }
        
    func repoSelected(at index: Int) {
        guard index >= 0 && !topSwiftRepos.isEmpty && index < topSwiftRepos.count else {
            return
        }
        router.presentRepoPullRequests(for: topSwiftRepos[index])
    }
}
