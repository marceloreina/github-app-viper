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
    
    static func makeRepos(jsonArray: [[String: Any]]) -> [Repo] {
        var repos = [Repo]()
        
        for jsonObject in jsonArray {
            if let repo = GitHubParser.makeRepo(jsonObject: jsonObject) {
                repos.append(repo)
            }
        }
        
        return repos
    }
    
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
}
