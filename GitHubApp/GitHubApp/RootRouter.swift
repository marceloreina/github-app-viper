//
//  RootRouter.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 02/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
    
    //MARK: RootWireframe implementation
    func presentTopSwiftReposScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = TopSwiftReposRouter.createModule()
    }
}
