//
//  TopSwiftReposInteractor.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 02/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation

class TopSwiftReposInteractor: TopSwiftReposUseCase {
    weak var output: TopSwiftReposInteractorOutput!
    
    func fetchTopSwiftRepos(pageNumber: Int) {
        GitHubService.repoSearch(
            languageName: "swift",
            sortedBy: "stars",
            pageNumber: pageNumber
        ) { result in
            
            switch result {
            case let .success(repos):
                self.output.topSwiftReposFetched(repos: repos)
            case .failure(error: _):
                self.output.failedToLoadRepos()
            }
        }
    }
}
