//
//  TopSwiftReposRouter.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 02/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit

class TopSwiftReposRouter: TopSwiftReposWireframe {
    weak var viewController: UIViewController?
    private static let ViewControllerStoryboardId = "TopSwiftReposViewController"
    
    static func createModule() -> UIViewController {
        let view = TopSwiftReposRouter.createFromStoryboard(name: "Wireframe")
        let presenter = TopSwiftReposPresenter()
        let interactor = TopSwiftReposInteractor()
        let router = TopSwiftReposRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        router.viewController = view
        
        
        let navigation = UINavigationController(rootViewController: view)
        return navigation
    }

    func presentRepoPullRequests(for repo: Repo) {
        if let navigation = viewController?.navigationController {
            let pullRequestsViewController = RepoPullRequestsRouter.createModule(for: repo)
            navigation.pushViewController(pullRequestsViewController, animated: true)
        }
        
    }
    
    //TODO change this to a UIViewController extension to stop repeating code
    private static func createFromStoryboard(name: String) -> TopSwiftReposViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: TopSwiftReposRouter.ViewControllerStoryboardId)
        return viewController as! TopSwiftReposViewController
    }
}
