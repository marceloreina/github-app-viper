//
//  RepoDisplayData.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 27/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation

struct RepoDisplayData {
    let repoName: String
    let repoDescription: String
    let watchNumber: String
    let forkNumber: String
    let starNumber: String
    let ownerName: String
    let ownerProfileImageURL: URL
    
    init(from repo: Repo) {
        repoName = repo.name
        repoDescription = repo.repoDescription
        watchNumber = "\(repo.watchersCount)"
        forkNumber = "\(repo.forksCount)"
        starNumber = "\(repo.stargazersCount)"
        ownerName = repo.user.login
        ownerProfileImageURL = URL(string: repo.user.avatarURL)!
    }    
}
