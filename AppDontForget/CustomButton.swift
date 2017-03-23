//
//  CustomButton.swift
//  AppDontForget
//
//  Created by Prang on 1/10/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import UIKit

@IBDesignable  class CustomButton: UIButton {
   @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        
        }
    
    
    }

}
