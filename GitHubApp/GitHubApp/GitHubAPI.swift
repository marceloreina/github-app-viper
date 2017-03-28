//
//  GitHubAPI.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 04/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation
import Moya


/// GitHub API endpoints
enum GitHubAPI {
    /// - searchRepositories: fetch repositories from specific `languageName`, sorted by `sortAttribute`. The response is paginated and this control is provided by `pageNumber`
    case searchRepositories(languageName: String, sortAttribute: String, pageNumber: Int)
    case listPullRequests(ownerLogin: String, repoName: String, stateAttribute: String, sortAttribute: String)
}


// MARK: - Target Type (Moya) implementation
extension GitHubAPI: TargetType {
    
    /// GitHub base URL
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    /// Endpoint path
    public var path: String {
        switch self {
        case .searchRepositories(_, _, _):
            return "/search/repositories"
        case .listPullRequests(let ownerLogin, let repoName, _, _):
            return "/repos/\(ownerLogin)/\(repoName)/pulls"
        }
    }
    
    /// These `parameters` are used to create query string for `.get` requests or formtatted as body on `.post` requests
    public var parameters: [String: Any]? {
        switch self {
        case .searchRepositories(let language, let sortType, let pageNumber):
            return ["q": "language:\(language)", "sort": sortType, "page": pageNumber]
        case .listPullRequests(_, _, let stateAttribute, let sortAttribute):
            return ["state": stateAttribute, "sort": sortAttribute, "direction": "desc"]
        }
    }
        
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// HTTP method. Just using `.get` for now.
    public var method: Moya.Method {
        return .get
    }
    
    /// Should me used for testing. Not used for now.
    public var sampleData: Data {
        return Data()
    }
    
    /// Task type. Just using `.request` for now.
    public var task: Task {
        return .request
    }
}
