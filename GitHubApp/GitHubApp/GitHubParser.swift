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
            guard let id = jsonObject["id"] as? Int64 else {
                break;
            }
            
            guard let name = jsonObject["name"] as? String else {
                break;
            }
            
            guard let watchersCount = jsonObject["watchers_count"] as? Int64 else {
                break;
            }
            
            guard let forksCount = jsonObject["forks_count"] as? Int64 else {
                break;
            }
            
            guard let stargazersCount = jsonObject["stargazers_count"] as? Int64 else {
                break;
            }
            
            guard let reposDescription = jsonObject["description"] as? String else {
                break;
            }
            
            guard let userJsonObject = jsonObject["owner"] as? [String: Any] else {
                break;
            }
            guard let user = GitHubParser.makeUser(jsonObject: userJsonObject) else {
                break;
            }
            
            let repo = Repo(id: id,
                            name: name,
                            watchersCount: watchersCount,
                            forksCount: forksCount,
                            stargazersCount: stargazersCount,
                            repoDescription: reposDescription,
                            user: user)
                
            repos.append(repo)
            
        }
        
        return repos
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
