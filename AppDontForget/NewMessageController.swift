//
//  NewMessageController.swift
//  AppDontForget
//
//  Created by Prang on 3/20/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//
import Firebase
import UIKit

class NewMessageController: UITableViewController {
   
    
    var dataBaseRef: FIRDatabaseReference! {
        
        return FIRDatabase.database().reference()
    }
    var storageRef: FIRStorage {
        
        return FIRStorage.storage()
    }

    
    let cellId = "cellId"
    
    var users = [User]()
    

    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
    }
    
    
       
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    

    
    func fetchUser(_ users: User){
        let users = users.uid
        
        print(users!)
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

   
}
