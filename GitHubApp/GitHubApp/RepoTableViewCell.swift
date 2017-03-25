//
//  RepoTableViewCell.swift
//  GitHubApp
//
//  Created by Marcelo Reina on 07/03/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit
import Haneke

class RepoTableViewCell: UITableViewCell {
    
    static let cellHeight: CGFloat = 174.0

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var watchNumber: UILabel!
    @IBOutlet weak var forkNumber: UILabel!
    @IBOutlet weak var starNumber: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var ownerProfileImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ownerProfileImage.clipsToBounds = true
        ownerProfileImage.layer.cornerRadius = 15
    }
    
    func setupCell(data: RepoDisplayData) {
        name.text = data.repoName
        repoDescription.text = data.repoDescription
        watchNumber.text = data.watchNumber
        forkNumber.text = data.forkNumber
        starNumber.text = data.starNumber
        ownerName.text  = data.ownerName
        ownerProfileImage.image = UIImage(named: "icon")
        ownerProfileImage.hnk_setImage(from: data.ownerProfileImageURL)
    }

}
