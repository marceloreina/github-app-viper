//
//  RepoPullRequestsRouter.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 11/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit

class RepoPullRequestsRouter: RepoPullRequestsWireframe {
    weak var viewController: UIViewController?
    private static let ViewControllerStoryboardId = "RepoPullRequestsViewController"
    
    static func createModule(for repo: Repo) -> UIViewController {
        let view = RepoPullRequestsRouter.createFromStoryboard(name: "Wireframe")
        let presenter = RepoPullRequestsPresenter()
        let interactor = RepoPullRequestsInteractor()
        let router = RepoPullRequestsRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.repo = repo
        
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
        
    private static func createFromStoryboard(name: String) -> RepoPullRequestsViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: RepoPullRequestsRouter.ViewControllerStoryboardId)
        return viewController as! RepoPullRequestsViewController
    }
}
