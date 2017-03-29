//
//  TSRPresenterTests.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 28/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import XCTest
@testable import GitHubApp

struct TRSExpectationDescription {
    static let loadRepoList = "loadRepoList"
    static let noContentToShow = "noContentToShow"
    static let failToLoad = "failToLoad"
    static let repoSelected = "repoSelected"
    
    private init() {}
}

class TSRPresenterTests: XCTestCase, TopSwiftReposUseCase, TopSwiftReposView, TopSwiftReposWireframe {
    
    let presenter: TopSwiftReposPresenter = TopSwiftReposPresenter()
    var expect: XCTestExpectation?
    var interactorOutput: TopSwiftReposInteractorOutput?
    
    var testUser: User!
    var testRepo: Repo!
    
    override func setUp() {
        super.setUp()
        
        presenter.interactor = self
        presenter.view = self
        presenter.router = self
        interactorOutput = presenter
        expect = nil
        
        testUser = User(id: 1, login: "userLogin", avatarURL: "https://www.google.com")
        testRepo = Repo(id: 1, name: "teste", watchersCount: 10, forksCount: 20, stargazersCount: 30, repoDescription: "repoTest", user: testUser)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPresenterLoadRepoList() {
        expect = expectation(description: TRSExpectationDescription.loadRepoList)
        presenter.loadRepoList()
        
        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssert(error == nil, "It should have no error")
        }
    }
    
    func testPresenterLoadMoreRepos() {
        expect = expectation(description: TRSExpectationDescription.loadRepoList)
        presenter.loadMoreRepos()
        
        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssert(error == nil, "It should have no error")
        }
    }
    
    func testPresenterNoContentToShow() {
        expect = expectation(description: TRSExpectationDescription.noContentToShow)
        presenter.loadMoreRepos()
        
        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssert(error == nil, "It should have no error")
        }
    }
    
    func testPresenterFailedToLoadRepos() {
        expect = expectation(description: TRSExpectationDescription.failToLoad)
        presenter.loadRepoList()
        
        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssert(error == nil, "It should have no error")
        }
    }
    
    func testPresenterSelectRepo() {
        expect = expectation(description: TRSExpectationDescription.repoSelected)
        
        //load repos first
        interactorOutput?.topSwiftReposFetched(repos: [testRepo])
        
        presenter.repoSelected(at: 0)
        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssert(error == nil, "It should have no error")
        }
    }
    
    func testPresenterSelectInvalidRepo() {
        presenter.repoSelected(at: -1)
        presenter.repoSelected(at: 0)
    }
    
    //MARK: TopSwiftReposUseCase implementation
    func fetchTopSwiftRepos(pageNumber: Int) {
        
        //perfect case
        if expect != nil && expect?.description == TRSExpectationDescription.loadRepoList {
            interactorOutput?.topSwiftReposFetched(repos: [testRepo])
        }
        
        //no content
        if expect != nil && expect?.description == TRSExpectationDescription.noContentToShow {
            interactorOutput?.topSwiftReposFetched(repos: [])
        }
        
        //error case
        if expect != nil && expect?.description == TRSExpectationDescription.failToLoad {
            interactorOutput?.failedToLoadRepos()
        }
    }
    
    //MARK: TopSwiftReposView
    func showRepos(repos: [RepoDisplayData]) {
        if expect != nil && expect?.description == TRSExpectationDescription.loadRepoList {
            XCTAssert(repos.count == 1)
            XCTAssert(repos[0].repoName == testRepo.name)
            XCTAssert(repos[0].watchNumber == "\(testRepo.watchersCount)")
            XCTAssert(repos[0].forkNumber == "\(testRepo.forksCount)")
            XCTAssert(repos[0].starNumber == "\(testRepo.stargazersCount)")
            XCTAssert(repos[0].repoDescription == "\(testRepo.repoDescription)")
            XCTAssert(repos[0].ownerName == "\(testRepo.user.login)")
            XCTAssert(repos[0].ownerProfileImageURL.absoluteString == testRepo.user.avatarURL)
            expect?.fulfill()
        }
    }
    
    func showNoContent() {
        if expect != nil && expect?.description == TRSExpectationDescription.failToLoad {
            expect?.fulfill()
        }
        
        if expect != nil && expect?.description == TRSExpectationDescription.noContentToShow {
            expect?.fulfill()
        }
    }
    
    //MARK: TopSwiftReposWireframe
    func presentRepoPullRequests(for repo: Repo) {
        if expect != nil && expect?.description == TRSExpectationDescription.repoSelected {
            XCTAssert(repo.name == testRepo.name)
            XCTAssert(repo.watchersCount == testRepo.watchersCount)
            XCTAssert(repo.forksCount == testRepo.forksCount)
            XCTAssert(repo.stargazersCount == testRepo.stargazersCount)
            XCTAssert(repo.repoDescription == testRepo.repoDescription)
            XCTAssert(repo.user.id == testRepo.user.id)
            XCTAssert(repo.user.login == testRepo.user.login)
            XCTAssert(repo.user.avatarURL == testRepo.user.avatarURL)
            expect?.fulfill()
        }
    }
    
    //Just to implement the protocol, not for test purpose
    weak var viewController: UIViewController?
    static func createModule() -> UIViewController {
        return UIViewController()
    }

}
