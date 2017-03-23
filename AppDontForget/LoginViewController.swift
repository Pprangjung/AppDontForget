//
//  LoginViewController.swift
//  AppDontForget
//
//  Created by Prang on 12/18/2559 BE.
//  Copyright © 2559 Prang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: AkiraTextField!
    @IBOutlet weak var passwordTF: AkiraTextField!
    let networkingService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        
    }
    
 @IBAction func loginAction(_ sender: Any) {
    networkingService.signIn(emailTF.text!, password: passwordTF.text!)
//    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home")
//    present(vc, animated: true, completion: nil)
    
    
   // let loginController=AddTodoTableViewController()
   // present(loginController,animated:true,completion:nil)
    
    }

}
