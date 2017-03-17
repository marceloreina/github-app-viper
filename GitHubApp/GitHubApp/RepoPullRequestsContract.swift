//
//  RepoPullRequestsContract.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 11/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit

protocol RepoPullRequestsPresentation: class {
    func viewDidLoad()
}

protocol RepoPullRequestsView: class {
    func showRepoTitle(text: String)
}

protocol RepoPullRequestsUseCase: class {
    
}

protocol RepoPullRequestsInteractorOutput: class {
    
}

protocol RepoPullRequestsWireframe: class {
    weak var viewController: UIViewController? { get set }
    static func createModule(for repo: Repo) -> UIViewController
}
