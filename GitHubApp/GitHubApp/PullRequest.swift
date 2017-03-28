//
//  PullRequest.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 27/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation

struct PullRequest {
    let id: Int64 /*id*/
    let title: String /*title*/
    let body: String /*body*/
    let state: String /*state*/
    let user: User /*user*/
    let createdAt: Date /*created_at*/
    
}
