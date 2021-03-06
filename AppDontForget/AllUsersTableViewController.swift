//
//  AllUsersTableViewController.swift
//  AppDontForget
//
//  Created by Prang on 2/25/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class AllUsersTableViewController: UITableViewController {

    
    
    var dataBaseRef: FIRDatabaseReference! {
        
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorage {
        
        return FIRStorage.storage()
    }
    
    var users = [User]()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
    }
    
  

    override func viewWillAppear(_ animated: Bool) {
       
        
        let usersRef = dataBaseRef.child("users")
        usersRef.observe(.value, with: { (snapshot) in
            
            
            var allUsers = [User]()
            
            
            for user in snapshot.children {
                
                var myself = User(snapshot: user as! FIRDataSnapshot)
                myself.uid = snapshot.key
                print("mu",myself.uid)
                
                
                if myself.username != FIRAuth.auth()!.currentUser!.displayName! {
                    
                    let newUser = User(snapshot: user as! FIRDataSnapshot)
                    allUsers.append(newUser)
                    print(newUser.username!)
                   
                }
                
            }
            self.users = allUsers
            
           self.tableView.reloadData()
            

            
            
        }) { (error) in
            
           print("error")        }
        
    }
   
    
      
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    var requestViewController: RequestViewController?

       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let usersRef = dataBaseRef.child("users")
        usersRef.observe(.value, with: { (snapshot) in
       
            for user in snapshot.children {
            let user =  User(snapshot: user as! FIRDataSnapshot)
        
            let currentUser =  self.users[indexPath.row]
                
                print("เข้ามั้ย??",currentUser.uid)
        self.requestViewController?.showChatControllerForUser(user: currentUser)

        
        
        
            }
        
        })
        
    }
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath) as! AllUsersInTableViewCell
        
        // Configure the cell...
        
         cell.usernameLabel.text = self.users[indexPath.row].username
        
        storageRef.reference(forURL: users[indexPath.row].photoUrl! ).data(withMaxSize: 1*1900*1900) { (data, error) in
            if error == nil {
                
                DispatchQueue.main.async(execute: {
                    if let data = data {
                        
                        cell.userImageView.image = UIImage(data: data)
                    }
                })
                
                
            }else {
                
               
                
            }
        }
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
}
