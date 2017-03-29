//
//  GitHubParserTests.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 18/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import XCTest
@testable import GitHubApp

class GitHubParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidUserJSON() {
        let id: Int64 = 100
        let login: String = "Test Login"
        let avatarURL: String = "http://test.url.com"
        
        let validJSON: [String: Any] = [
            "id": id,
            "login": login,
            "avatar_url": avatarURL
        ]
        
        let user = GitHubParser.makeUser(jsonObject: validJSON)
        XCTAssert(user != nil, "[GitHubParser] User: valid json should create a User object")
        XCTAssert(user!.id == id, "[GitHubParser] User: valid json should provide the correct id for User Object")
        XCTAssert(user!.login == login, "[GitHubParser] User: valid json should provide the correct login for User Object")
        XCTAssert(user!.avatarURL == avatarURL, "[GitHubParser] User: valid json should provide the correct id for User Object")
    }
    
    func testEmptyUserJSON() {
        let emptyJSON = [String: Any]()
        let user = GitHubParser.makeUser(jsonObject: emptyJSON)
        XCTAssert(user == nil, "[GitHubParser] User: empty json should return nil")
    }
    
    func testMissingIdUserJSON() {
        let login: String = "Test Login"
        let avatarURL: String = "http://test.url.com"
        
        let missingFieldJSON: [String: Any] = [
            "login": login,
            "avatar_url": avatarURL
        ]
        
        let user = GitHubParser.makeUser(jsonObject: missingFieldJSON)
        XCTAssert(user == nil, "[GitHubParser] User: missing id in json should return nil")
    }
    
    func testMissingLoginUserJSON() {
        let id: Int64 = 100
        let avatarURL: String = "http://test.url.com"
        
        let missingFieldJSON: [String: Any] = [
            "id": id,
            "avatar_url": avatarURL
        ]
        
        let user = GitHubParser.makeUser(jsonObject: missingFieldJSON)
        XCTAssert(user == nil, "[GitHubParser] User: missing login in json should return nil")
    }
    
    func testMissingAvatarURLUserJSON() {
        let id: Int64 = 100
        let login: String = "Test Login"
        
        let missingFieldJSON: [String: Any] = [
            "id": id,
            "login": login
        ]
        
        let user = GitHubParser.makeUser(jsonObject: missingFieldJSON)
        XCTAssert(user == nil, "[GitHubParser] User: missing avatar_url in json should return nil")
    }
    
    func testWrongTypeIdUserJSON() {
        let id: String = "100"
        let login: String = "Test Login"
        let avatarURL: String = "http://test.url.com"
        
        let wrongTypeJSON: [String: Any] = [
            "id": id,
            "login": login,
            "avatar_url": avatarURL
        ]
        
        let user = GitHubParser.makeUser(jsonObject: wrongTypeJSON)
        XCTAssert(user == nil, "[GitHubParser] User: wrong id type in json should return nil")
    }
    
    func testWrongTypeLoginUserJSON() {
        let id: Int64 = 100
        let login: Int = 120
        let avatarURL: String = "http://test.url.com"
        
        let wrongTypeJSON: [String: Any] = [
            "id": id,
            "login": login,
            "avatar_url": avatarURL
        ]
        
        let user = GitHubParser.makeUser(jsonObject: wrongTypeJSON)
        XCTAssert(user == nil, "[GitHubParser] User: wrong login type in json should return nil")
    }
    
    func testWrongTypeAvatarURLUserJSON() {
        let id: Int64 = 100
        let login: String = "Test Login"
        let avatarURL: Int = 0
        
        let wrongTypeJSON: [String: Any] = [
            "id": id,
            "login": login,
            "avatar_url": avatarURL
        ]
        
        let user = GitHubParser.makeUser(jsonObject: wrongTypeJSON)
        XCTAssert(user == nil, "[GitHubParser] User: wrong avatar_url type in json should return nil")
    }
    
    func testValidRepoJSON() {
        
        let id: Int64 = 100
        let name: String = "Repo Test"
        let watchersCount: Int64 = 200
        let forksCount: Int64 = 100000
        let stargazersCount: Int64 = 200000
        let repoDescription: String = "Repo description"
        let validUserJSON: [String: Any] = [
            "id": Int64(100),
            "login": "Test Login",
            "avatar_url": "http://test.url.com"
        ]
        
        let validRepoJSON: [String: Any] = [
            "id": id,
            "name": name,
            "watchers_count": watchersCount,
            "forks_count": forksCount,
            "stargazers_count": stargazersCount,
            "description": repoDescription,
            "owner": validUserJSON
        ]
        
        let repo = GitHubParser.makeRepo(jsonObject: validRepoJSON)
        XCTAssert(repo != nil, "[GitHubParser] Repo: valid json should create a Repo object")
        XCTAssert(repo!.id == id, "[GitHubParser] Repo: valid json should provide the correct id for Repo Object")
        XCTAssert(repo!.name == name, "[GitHubParser] Repo: valid json should provide the correct name for Repo Object")
        XCTAssert(repo!.watchersCount == watchersCount, "[GitHubParser] Repo: valid json should provide the correct watchersCount for Repo Object")
        XCTAssert(repo!.forksCount == forksCount, "[GitHubParser] Repo: valid json should provide the correct forksCount for Repo Object")
        XCTAssert(repo!.stargazersCount == stargazersCount, "[GitHubParser] Repo: valid json should provide the correct stargazersCount for Repo Object")
        XCTAssert(repo!.repoDescription == repoDescription, "[GitHubParser] Repo: valid json should provide the correct repoDescription for Repo Object")
    }
    
    func testEmptyRepoJSON() {
        let emptyJSON = [String: Any]()
        let repo = GitHubParser.makeRepo(jsonObject: emptyJSON)
        XCTAssert(repo == nil, "[GitHubParser] Repo: empty json should return nil")
    }
    
    func testMissingIdRepoJSON() {
        let name: String = "Repo Test"
        let watchersCount: Int64 = 200
        let forksCount: Int64 = 100000
        let stargazersCount: Int64 = 200000
        let repoDescription: String = "Repo description"
        let validUserJSON: [String: Any] = [
            "id": Int64(100),
            "login": "Test Login",
            "avatar_url": "http://test.url.com"
        ]
        
        let missingFieldJSON: [String: Any] = [
            "name": name,
            "watchers_count": watchersCount,
            "forks_count": forksCount,
            "stargazers_count": stargazersCount,
            "description": repoDescription,
            "owner": validUserJSON
        ]
        
        let repo = GitHubParser.makeRepo(jsonObject: missingFieldJSON)
        XCTAssert(repo == nil, "[GitHubParser] Repo: missing id in json should return nil")
    }
    
    func testMissingNameRepoJSON() {
        let id: Int64 = 100
        let watchersCount: Int64 = 200
        let forksCount: Int64 = 100000
        let stargazersCount: Int64 = 200000
        let repoDescription: String = "Repo description"
        let validUserJSON: [String: Any] = [
            "id": Int64(100),
            "login": "Test Login",
            "avatar_url": "http://test.url.com"
        ]
        
        let missingFieldJSON: [String: Any] = [
            "id": id,
            "watchers_count": watchersCount,
            "forks_count": forksCount,
            "stargazers_count": stargazersCount,
            "description": repoDescription,
            "owner": validUserJSON
        ]
        
        let repo = GitHubParser.makeRepo(jsonObject: missingFieldJSON)
        XCTAssert(repo == nil, "[GitHubParser] Repo: missing name in json should return nil")
    }
    
    func testMissingWatchersCountRepoJSON() {
        let id: Int64 = 100
        let name: String = "Repo Test"
        let forksCount: Int64 = 100000
        let stargazersCount: Int64 = 200000
        let repoDescription: String = "Repo description"
        let validUserJSON: [String: Any] = [
            "id": Int64(100),
            "login": "Test Login",
            "avatar_url": "http://test.url.com"
        ]
        
        let missingFieldJSON: [String: Any] = [
            "id": id,
            "name": name,
            "forks_count": forksCount,
            "stargazers_count": stargazersCount,
            "description": repoDescription,
            "owner": validUserJSON
        ]
        
        let repo = GitHubParser.makeRepo(jsonObject: missingFieldJSON)
        XCTAssert(repo == nil, "[GitHubParser] Repo: missing watchers_count in json should return nil")
    }
    
    func testMissingForksCountRepoJSON() {
        let id: Int64 = 100
        let name: String = "Repo Test"
        let watchersCount: Int64 = 200
        let stargazersCount: Int64 = 200000
        let repoDescription: String = "Repo description"
        let validUserJSON: [String: Any] = [
            "id": Int64(100),
            "login": "Test Login",
            "avatar_url": "http://test.url.com"
        ]
        
        let missingFieldJSON: [String: Any] = [
            "id": id,
            "name": name,
            "watchers_count": watchersCount,
            "stargazers_count": stargazersCount,
            "description": repoDescription,
            "owner": validUserJSON
        ]
        
        let repo = GitHubParser.makeRepo(jsonObject: missingFieldJSON)
        XCTAssert(repo == nil, "[GitHubParser] Repo: missing forks_count in json should return nil")
    }
    
    func testMissingStargazersCountRepoJSON() {
        let id: Int64 = 100
        let name: String = "Repo Test"
        let watchersCount: Int64 = 200
        let forksCount: Int64 = 100000
        let repoDescription: String = "Repo description"
        let validUserJSON: [String: Any] = [
            "id": Int64(100),
            "login": "Test Login",
            "avatar_url": "http://test.url.com"
        ]
        
        let missingFieldJSON: [String: Any] = [
            "id": id,
            "name": name,
            "watchers_count": watchersCount,
            "forks_count": forksCount,
            "description": repoDescription,
            "owner": validUserJSON
        ]
        
        let repo = GitHubParser.makeRepo(jsonObject: missingFieldJSON)
        XCTAssert(repo == nil, "[GitHubParser] Repo: missing stargazers_count in json should return nil")
    }
    
    func testMissingRepoDescriptionRepoJSON() {
        let id: Int64 = 100
        let name: String = "Repo Test"
        let watchersCount: Int64 = 200
        let forksCount: Int64 = 100000
        let stargazersCount: Int64 = 200000
        let validUserJSON: [String: Any] = [
            "id": Int64(100),
            "login": "Test Login",
            "avatar_url": "http://test.url.com"
        ]
        
        let missingFieldJSON: [String: Any] = [
            "id": id,
            "name": name,
            "watchers_count": watchersCount,
            "forks_count": forksCount,
            "stargazers_count": stargazersCount,
            "owner": validUserJSON
        ]
        
        let repo = GitHubParser.makeRepo(jsonObject: missingFieldJSON)
        XCTAssert(repo == nil, "[GitHubParser] Repo: missing description in json should return nil")
    }
    
    func testMissingOwnerRepoJSON() {
        let id: Int64 = 100
        let name: String = "Repo Test"
        let watchersCount: Int64 = 200
        let forksCount: Int64 = 100000
        let stargazersCount: Int64 = 200000
        let repoDescription: String = "Repo description"
        
        let missingFieldJSON: [String: Any] = [
            "id": id,
            "name": name,
            "watchers_count": watchersCount,
            "forks_count": forksCount,
            "stargazers_count": stargazersCount,
            "description": repoDescription,
        ]
        
        let repo = GitHubParser.makeRepo(jsonObject: missingFieldJSON)
        XCTAssert(repo == nil, "[GitHubParser] Repo: missing owner in json should return nil")
    }

    func testValidReposArrayJSON() {
        let id: Int64 = 100
        let name: String = "Repo Test"
        let watchersCount: Int64 = 200
        let forksCount: Int64 = 100000
        let stargazersCount: Int64 = 200000
        let repoDescription: String = "Repo description"
        let validUserJSON: [String: Any] = [
            "id": Int64(100),
            "login": "Test Login",
            "avatar_url": "http://test.url.com"
        ]
        
        let validRepoJSON: [String: Any] = [
            "id": id,
            "name": name,
            "watchers_count": watchersCount,
            "forks_count": forksCount,
            "stargazers_count": stargazersCount,
            "description": repoDescription,
            "owner": validUserJSON
        ]
        
        let jsonArray: [[String: Any]] = [
            validRepoJSON,
            validRepoJSON
        ]
        
        let repos = GitHubParser.makeRepos(jsonArray: jsonArray)
        XCTAssert(repos.count == jsonArray.count, "[GitHubParser] Repos: valid json should create the same number of elements")
    }
    
    func testEmptyReposArrayJSON() {
    
    }
}
