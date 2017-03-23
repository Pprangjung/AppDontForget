//
//  TodoListTableViewController.swift
//  AppDontForget
//
//  Created by Prang on 1/13/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


//import ImageLoader

class TodoListTableViewController: UITableViewController{
    
    var storageRef: FIRStorageReference!

    
    
    var databaseRef : FIRDatabaseReference!
    
    
    /*
    struct Objects {
        var dateSection:String!
        var todoArray:[TodoList] = []

    }
    var objectsArray = [Objects]()
    */
    
    var todoArray:[TodoList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FIRAuth.auth()?.currentUser==nil{
            
    
             let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home")
            self.present(vc,animated: true,completion: nil)
        
        }
        
        else{
        
            //ปรับใหม่
       let uid = FIRAuth.auth()?.currentUser?.uid         
       let  databaseRef = FIRDatabase.database().reference().child("allTasks").child(uid!)
        
            
        databaseRef.observe(.value, with: { (snapshot) in
            
            var newItems = [TodoList]()
           
           
            
            for item in snapshot.children {
                
               
                let newTodo = TodoList(snapshot: item as! FIRDataSnapshot)
                let letter = newTodo.dateLabel
               
                
            newItems.insert(newTodo, at: 0)
               
                
            }
            self.todoArray = newItems
            
            
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })

            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        }
        
    
    
}
    
    typealias MailActionCallback = (_ cancelled: Bool, _ deleted: Bool, _ actionIndex: Int) -> Void
    
    func swipeTableCell(_ cell: MGSwipeTableCell, canSwipe direction: MGSwipeDirection) -> Bool {
        return true;
    }
    
 /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        return todoArray.count
    }
 
  */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //let todoLine = todoArray[section]
        return  todoArray.count
    }

    /*
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let todoLine = todoArray[section]
        return  todoLine.dateLabel
    }
 */
   

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TodoTableViewCell
        cell.todoItemName.text = self.todoArray[indexPath.row].title
        cell.todoDescription.text = self.todoArray[indexPath.row].content
        cell.usernameLabel.text = self.todoArray[indexPath.row].username
        
        let  picNoteStringUrl = self.todoArray[indexPath.row].picNoteStringUrl
        let  userImageViewStringUrl = self.todoArray[indexPath.row].userImageViewStringUrl
       
        
        FIRStorage.storage().reference(forURL: picNoteStringUrl!).data(withMaxSize: 10 * 1024 * 1024, completion: { (data, error) in
            if error == nil {
                DispatchQueue.main.async(execute: {
                    if let picNoteStringUrl = UIImage(data:data!) {
                        cell.picNote.image = picNoteStringUrl
                        print("testpass",picNoteStringUrl)
                    }
                    
                })
                
                
            }else {
                print(error!.localizedDescription,"555")
                
            }
        })
    
        FIRStorage.storage().reference(forURL: userImageViewStringUrl!).data(withMaxSize: 10 * 1024 * 1024, completion: { (data, error) in
            if error == nil {
                DispatchQueue.main.async(execute: {
                    if let userImageViewStringUrl = UIImage(data:data!) {
                        cell.userImageView.image = userImageViewStringUrl
                        print("testpass",userImageViewStringUrl)
                    }
                    
                })
                
                
            }else {
                print(error!.localizedDescription,"555")
                
            }
        })
        
        
        
        //configure left buttons
        
       
        cell.leftButtons = [MGSwipeButton(title: "check", icon: UIImage(named:"check.png"), backgroundColor: .blue)]
        cell.leftSwipeSettings.transition = MGSwipeTransition.border
        
        //configure right buttons
        cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: .red),
                             MGSwipeButton(title: "More",backgroundColor: .lightGray)]
        cell.rightSwipeSettings.transition = .border
        
            return cell
    }
    
    
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   //  performSegue(withIdentifier: "updateTodo", sender: self)
       // แสดงให้เข้าหน้าไหน
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        
        return true
    }
    
    
    
    
    
       /*
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath:IndexPath) -> [UITableViewRowAction]? {
     
        let delete = UITableViewRowAction(style: .default, title: "\u{267A}\n Delete") { action, index in
            print("more button tapped")
            let    ref = self.todoArray[indexPath.row].ref
            ref?.removeValue()
            self.todoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        delete.backgroundColor = UIColor.red
        
        let check = UITableViewRowAction(style: .default, title: "\u{2611}\n check") { action, index in
            print("edit button tapped")
            
          
        
        }
        check.backgroundColor = UIColor.orange
 
        
        return true
 

    } */
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="updateTodo"{
        let vc = segue.destination as! UpdateTableViewController
        let indexPath = tableView.indexPathForSelectedRow!
        vc.todo = todoArray[indexPath.row]
        
        }

    }

   }
