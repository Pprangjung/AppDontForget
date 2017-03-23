//
//  RequestViewController.swift
//  AppDontForget
//
//  Created by Prang on 2/26/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase


 var user : User!


class RequestViewController: UIViewController {
    
    
    var dataBaseRef: FIRDatabaseReference! {
        
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorage {
        
        return FIRStorage.storage()
    }
    
    
    
   var selectedUserID = String()
    
    func showChatControllerForUser(user: User){
        let chatLogController = RequestViewController()
        chatLogController.selectedUserID  = user.uid
        navigationController?.pushViewController(chatLogController, animated: true)
    }


    @IBOutlet weak var Message: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
  
    @IBAction func handelSend(_ sender: Any){
        let ref = FIRDatabase.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let toId = user!.uid!
        
        let fromId = FIRAuth.auth()!.currentUser!.uid
    
        let  text = self.Message.text
        
        let sendText = SendText(text: text!, toId: toId, fromId: fromId)
        
    }




}
