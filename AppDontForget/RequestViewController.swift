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

 var user: User?
 var message: Message?

class RequestViewController: UIViewController {

    @IBOutlet weak var Message: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func handleSend(_ sender: Any) {
        let ref = FIRDatabase.database().reference().child("Send")
        let childRef = ref.childByAutoId()
        
        
        let  toID = user?.uid!
        print(user?.uid!) //  nil
        
        let fromID = FIRAuth.auth()!.currentUser!.uid
        let timeStamp = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        let value = ["text":Message.text!,"toID":toID,"fromID":fromID,"timeStamp":timeStamp] as [String : Any]
        childRef.updateChildValues(value)
        print(Message.text!)
    }

}
