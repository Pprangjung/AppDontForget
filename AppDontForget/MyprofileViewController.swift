//
//  MyprofileViewController.swift
//  AppDontForget
//
//  Created by Prang on 1/11/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MyprofileViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userImageView: CustomableImageView!
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func updateName(_ sender: Any) {
        
    }
    
    
    
    @IBAction func updateEmail(_ sender: Any) {
    
        if let user = FIRAuth.auth()?.currentUser{
            user.updateEmail(email.text!, completion: {(Error)in
                if let Error = Error{
                    print(Error.localizedDescription)}
                    
                else { let alertview = UIAlertView(title:"Update Your Email", message:"You have update new email", delegate:self,cancelButtonTitle: "ok")
                
                    alertview.show() }
            })
        }
   }
    
    
    @IBAction func updatePassword(_ sender: Any) {
        
    }
    
    
    
    @IBAction func deleteAccount(_ sender: Any) {
        
    }
    
    
    var databaseRef: FIRDatabaseReference!{
    return FIRDatabase.database().reference()
    
    }
    var storageRef: FIRStorage!{
        return FIRStorage.storage()
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadUserInfo()
    }
    
    func loadUserInfo(){
        
       
        
        let userRef = databaseRef.child("users/\(FIRAuth.auth()!.currentUser!.uid)")
        userRef.observe(.value, with: { (snapshot) in
            
           let user = User(snapshot: snapshot)
            
            self.username.text = user.username
            self.email.text = user.email
            
          
            let imageUrl = String(user.photoUrl)
            
            self.storageRef.reference(forURL: imageUrl!).data(withMaxSize: 1 * 1900 * 1900, completion: { (data, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                }else {
                    if let data = data {
                        self.userImageView.image = UIImage(data: data)
                    }
                }
            }) //ขนาดภาพที่จะโหลดขึ้นมาใช้
            
            
 
            
            
            
            
            
            
        }) { (error) in
             print("wrong-position2")        }
        
        
        
       
        
        
    }
    
    

 
    
    func logOutAction(_ sender: Any) {
        
        if FIRAuth.auth()?.currentUser != nil {
            
            do {
                
                try  FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    

   
}
