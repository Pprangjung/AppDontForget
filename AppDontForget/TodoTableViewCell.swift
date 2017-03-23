//
//  TodoTableViewCell.swift
//  AppDontForget
//
//  Created by Prang on 1/13/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import UIKit

class TodoTableViewCell: MGSwipeTableCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var todoDescription: UITextView!
    @IBOutlet weak var todoItemName: UILabel!
   
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var picNote: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = 15
        
    }


    
    
    
    
}
