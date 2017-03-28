//
//  GitHubService.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 04/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation
import Moya

enum GitHubAPIError: Swift.Error {
    case invalidResponse
    case httpError(httpCode: Int)
    case invalidObjectMapping
    case invalidJSONFormat
}

/// GitHub API Result type
/// It uses generics for flexibility and describes a pattern to be followed for all resposnses
///
/// - success: Must provide an `object` already mapped from JSON
/// - failure: Must provide an specific error
enum GitHubAPIResult<T> {
    case success(object: T)
    case failure(error: GitHubAPIError)
}

/// Alias for repositories search completion handler
typealias RepoSearchCompletion = (GitHubAPIResult<[Repo]>) -> Void

/// Alias for repositories search completion handler
typealias ListPullRequestsCompletion = (GitHubAPIResult<[PullRequest]>) -> Void


class GitHubService {
    
    /// Search Git Hub repos for a desired programming language and order the results based 
    ///  on the `sortedBy` attribute. This request is paginated. For more details on
    ///  attribute values please check Git Hub API doucmentation
    ///
    /// - Parameters:
    ///   - languageName: programming language to be searched
    ///   - sortedBy: attribute name used to sort the results
    ///   - pageNumber: number of the page that should be fetched (beginning in 1)
    ///   - completion: handler that receives `GitHubAPIResult` as parameter
    static func repoSearch(languageName: String, sortedBy: String, pageNumber: Int, completion: @escaping RepoSearchCompletion) {
        let provider = MoyaProvider<GitHubAPI>()
        provider.request(
            GitHubAPI.searchRepositories(
                languageName: languageName,
                sortAttribute: sortedBy,
                pageNumber: pageNumber
            )
        ) { result in
            switch result {
                case let .success(moyaResponse):
                    
                    // Check for invalid status code
                    let statusCode = moyaResponse.statusCode
                    guard statusCode == 200 else {
                        completion(.failure(error: .httpError(httpCode: statusCode)))
                        return
                    }
                
                    // Check response data
                    let data = moyaResponse.data
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                    guard json != nil else {
                        completion(.failure(error: .invalidObjectMapping))
                        return
                    }
                    
                    // Mapping JSON -> Object
                    guard let itemsJSON = json!["items"] as? [[String: Any]] else {
                        completion(.failure(error: .invalidJSONFormat))
                        return
                    }
                        
                    let repos = GitHubParser.makeRepos(jsonArray: itemsJSON)
                        completion(.success(object: repos))
                
                case .failure(_):
                    completion(.failure(error: .invalidResponse))
            }
        }
    }
    
    static func listPullRequests(ownerLogin: String, repoName: String, state: String, sortedBy: String, completion: @escaping ListPullRequestsCompletion) {
        let provider = MoyaProvider<GitHubAPI>()
        provider.request(.listPullRequests(
            ownerLogin: ownerLogin,
            repoName: repoName,
            stateAttribute: state,
            sortAttribute: sortedBy
            )
        ) { (result) in
            switch result {
            case let .success(moyaResponse):
                
                // Check for invalid status code
                let statusCode = moyaResponse.statusCode
                guard statusCode == 200 else {
                    completion(.failure(error: .httpError(httpCode: statusCode)))
                    return
                }
                
                // Check response data
                let data = moyaResponse.data
                let jsonArray = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
                guard jsonArray != nil else {
                    completion(.failure(error: .invalidObjectMapping))
                    return
                }
                
                // Mapping JSON -> Object
                let pullRequests = GitHubParser.makePullRequests(jsonArray: jsonArray!)
                completion(.success(object: pullRequests))
                
            case .failure(_):
                completion(.failure(error: .invalidResponse))
            }
        }
    }
}
