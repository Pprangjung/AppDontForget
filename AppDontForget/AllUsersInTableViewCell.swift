//
//  AllUsersInTableViewCell.swift
//  AppDontForget
//
//  Created by Prang on 2/25/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import UIKit

class AllUsersInTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
       userImageView.layer.cornerRadius = 25
    }

  
}
