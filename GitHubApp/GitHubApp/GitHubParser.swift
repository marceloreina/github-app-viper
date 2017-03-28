//
//  GitHubParser.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 04/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation
import Moya

class GitHubParser {
    
    /// <#Description#>
    ///
    /// - Parameter jsonArray: <#jsonArray description#>
    /// - Returns: <#return value description#>
    static func makeRepos(jsonArray: [[String: Any]]) -> [Repo] {
        var repos = [Repo]()
        
        for jsonObject in jsonArray {
            if let repo = GitHubParser.makeRepo(jsonObject: jsonObject) {
                repos.append(repo)
            }
        }
        
        return repos
    }
    
    /// <#Description#>
    ///
    /// - Parameter jsonObject: <#jsonObject description#>
    /// - Returns: <#return value description#>
    static func makeRepo(jsonObject: [String: Any]) -> Repo? {
        guard let id = jsonObject["id"] as? Int64 else {
            return nil
        }
        
        guard let name = jsonObject["name"] as? String else {
            return nil
        }
        
        guard let watchersCount = jsonObject["watchers_count"] as? Int64 else {
            return nil
        }
        
        guard let forksCount = jsonObject["forks_count"] as? Int64 else {
            return nil
        }
        
        guard let stargazersCount = jsonObject["stargazers_count"] as? Int64 else {
            return nil
        }
        
        guard let reposDescription = jsonObject["description"] as? String else {
            return nil
        }
        
        guard let userJsonObject = jsonObject["owner"] as? [String: Any] else {
            return nil
        }
        guard let user = GitHubParser.makeUser(jsonObject: userJsonObject) else {
            return nil
        }
        
        let repo = Repo(id: id,
                        name: name,
                        watchersCount: watchersCount,
                        forksCount: forksCount,
                        stargazersCount: stargazersCount,
                        repoDescription: reposDescription,
                        user: user)
        return repo
    }
    
    /// <#Description#>
    ///
    /// - Parameter jsonObject: <#jsonObject description#>
    /// - Returns: <#return value description#>
    static func makeUser(jsonObject: [String: Any]) -> User? {
        guard let id = jsonObject["id"] as? Int64 else {
            return nil
        }
        
        guard let login = jsonObject["login"] as? String else {
            return nil
        }
        
        guard let avatarURL = jsonObject["avatar_url"] as? String else {
            return nil
        }
        
        return User(id: id,
                    login: login,
                    avatarURL: avatarURL)
    }
    
    /// <#Description#>
    ///
    /// - Parameter jsonArray: <#jsonArray description#>
    /// - Returns: <#return value description#>
    static func makePullRequests(jsonArray: [[String: Any]]) -> [PullRequest] {
        var listOfPullRequests = [PullRequest]()
        
        for jsonObject in jsonArray {
            if let pullRequest = GitHubParser.makePullRequest(jsonObject: jsonObject) {
                listOfPullRequests.append(pullRequest)
            }
        }
        
        return listOfPullRequests
    }
    
    /// <#Description#>
    ///
    /// - Parameter jsonObject: <#jsonObject description#>
    /// - Returns: <#return value description#>
    static func makePullRequest(jsonObject: [String: Any]) -> PullRequest? {
        guard let id = jsonObject["id"] as? Int64 else {
            return nil
        }
    
        guard let title = jsonObject["title"] as? String else {
            return nil
        }
    
        guard let body = jsonObject["body"] as? String else {
            return nil
        }
        
        guard let state = jsonObject["state"] as? String else {
            return nil
        }
        
        guard let userJsonObject = jsonObject["user"] as? [String: Any] else {
            return nil
        }
        guard let user = GitHubParser.makeUser(jsonObject: userJsonObject) else {
            return nil
        }
        
        guard let createdAtString = jsonObject["created_at"] as? String else {
            return nil
        }
        guard let createdAt = Date.makeDate(from: createdAtString) else {
            return nil
        }
    
        return PullRequest(id: id,
                           title: title,
                           body: body,
                           state: state,
                           user: user,
                           createdAt: createdAt)
    }
}
