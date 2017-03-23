//
//  ResetPasswordViewController.swift
//  AppDontForget
//
//  Created by Prang on 1/9/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import UIKit
import Firebase
class ResetPasswordViewController: UIViewController {
 
    @IBOutlet weak var emailTF: AkiraTextField!
    let networkingService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

           }

    @IBAction func resetPasswordAction(_ sender: Any) {
        networkingService.resetPassword(emailTF.text!)
        
    }
    
   }
