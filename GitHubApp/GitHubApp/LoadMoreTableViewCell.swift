//
//  LoadMoreTableViewCell.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 25/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit

class LoadMoreTableViewCell: UITableViewCell {

    static let cellHeight: CGFloat = 100
    
    @IBOutlet weak var loadingMessage: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func setupCell(message: String) {
        activityIndicator.startAnimating()
        loadingMessage.text = message
    }

}
