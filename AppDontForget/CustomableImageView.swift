//
//  CustomableImageView.swift
//  AppDontForget
//
//  Created by Prang on 1/10/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import UIKit

@IBDesignable   class CustomableImageView: UIImageView {
    @IBInspectable var cornerRaDius: CGFloat = 0  {
        didSet{
       layer.cornerRadius = cornerRaDius
        
        }
    
    }
    
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet{
        layer.borderWidth = borderWidth
        
        }
    
    }
    
  
    
    
}
