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
    
    static func createModule() -> UIViewController {
        let view = TopSwiftReposViewController.createFromStoryboard(name: "Wireframe")
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
}
