//
//  TopSwiftReposContract.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 02/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation

protocol TopSwiftReposPresentation: class {
    func viewDidLoad()
}

protocol TopSwiftReposView: class {
    func showRepos(repos: [RepoDisplayData])
    func showNoContent()
    var currentPage: Int {get}
}

protocol TopSwiftReposUseCase: class {
    func fetchTopSwiftRepos(pageNumber: Int)
}

protocol TopSwiftReposInteractorOutput: class {
    func topSwiftReposFetched(repos: [Repo])
    func failedToLoadRepos()
}

protocol TopSwiftReposWireframe: class {
    
}

struct RepoDisplayData {
    let repoName: String
    let repoDescription: String
    let watchNumber: String
    let forkNumber: String
    let starNumber: String
    let ownerName: String
    let ownerProfileImageURL: URL
}
