//
//  Repo.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 04/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation

struct Repo {
    let id: Int64
    let name: String /*name*/
    let watchersCount: Int64 /*watchers_count*/
    let forksCount: Int64 /*forks_count*/
    let stargazersCount: Int64 /*stargazers_count*/
    let repoDescription: String /*description*/
    let user: User /*owner*/
}
