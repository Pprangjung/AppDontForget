//
//  UpdateTableViewController.swift
//  AppDontForget
//
//  Created by Prang on 1/14/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class UpdateTableViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,setDateValueDelegate {
    
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
   
    @IBOutlet weak var picNote: UIImageView!
    
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var pickerImg = UIImagePickerController()

    var todo:TodoList!
    var databaseRef:FIRDatabaseReference! {
        return FIRDatabase.database().reference()
        
        
    }
    
    
    //ให้วันที่โผล่ออกมา
    func setDate(value toValue:String) {
        let date = toValue
        dateLabel.text = date
        print("ออกมาแล้ว")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showVC") {
            let secondVC = (segue.destination as! ViewController)
            secondVC.delegate = self
        }
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        descriptionTF.text = todo.content
        itemName.text = todo.title
        
    }
    //เลือกอิมเมจ
    
    

    @IBAction func loadImageButtonTapped(_ sender: Any) {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            pickerImg =  UIImagePickerController()
            pickerImg.delegate = self
            pickerImg.sourceType = .camera
            
            present(pickerImg, animated: true, completion: nil)
        } else {
            pickerImg.allowsEditing = false
            pickerImg.sourceType = .photoLibrary
            pickerImg.delegate = self
            present(pickerImg, animated: true, completion:nil)
        }
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        pickerImg.dismiss(animated: true, completion: nil)
        picNote.contentMode = .scaleAspectFill
        picNote.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
           }
    
    

    
    
       @IBAction func updateAction(_ sender: Any) {
        // let todoRef = databaseRef.child("allTasks").childByAutoId()
        
        
        var title =  String()
        if itemName.text == ""{
            
            itemName.text = "No item name"
            title = itemName.text!
        }else{
            
            title = itemName.text!
        }
        
        var content = String()
        
        if descriptionTF.text == "" {
            descriptionTF.text = "No description for this Todo"
            content = descriptionTF.text!
        }else{
            content = descriptionTF.text!
        }
        
        
//        if let text = self.dateLabel.text {
            let dateLabel = self.dateLabel.text//String(self.dateLabel.text!)
//        }
        
        let updateTodo = TodoList(title: title, content: content, username: FIRAuth.auth()!.currentUser!.displayName!, picNoteStringUrl: todo.picNoteStringUrl, userImageViewStringUrl: todo.userImageViewStringUrl, postId:todo.postId, dateLabel: todo.dateLabel)
        
       
        
        
        let key = todo.ref!.key
        //let twooo = databaseRef.child(FIRAuth.auth()!.currentUser!.uid)
        let updateRef = databaseRef.child("/allTasks/\(FIRAuth.auth()!.currentUser!.uid)\(key)")
        //databaseRef.child("allTasks").child(FIRAuth.auth()!.currentUser!.uid).childByAutoId()
        updateRef.updateChildValues(updateTodo.toAnyObject())
        
        self.navigationController?.popToRootViewController(animated: true)
        
        
        
        
        
    }
    
}
