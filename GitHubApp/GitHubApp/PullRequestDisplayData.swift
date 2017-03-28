//
//  PullRequestDisplayData.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 27/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation

struct PullRequestDisplayData {
    let title: String
    let body: String
    let createdAt: String
    let state: String
    
    init(from pullRequest: PullRequest) {
        title = pullRequest.title
        body = pullRequest.body
        createdAt = pullRequest.createdAt.shortDateString()
        state = pullRequest.state
    }
}
