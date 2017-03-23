//
//  AddTodoViewController.swift
//  AppDontForget
//
//  Created by Prang on 1/9/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import FirebaseMessaging

class AddTodoTableViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,setDateValueDelegate{
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var picNote: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
   
    
    
    var pickerImg = UIImagePickerController()
   
    var databaseRef:FIRDatabaseReference! {
        return FIRDatabase.database().reference()
        
    }
    
    var storageRef: FIRStorageReference! {
        return FIRStorage.storage().reference()
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
    
    
    
    
    //ฟังก์ชั่นเพื่อเก็บ task เข้าดาต้าเบส
    @IBAction func saveAction(_ sender: Any) {
        
        
        // current user fetch user into  database ที่ปรับใหม่
        
        
        let todoRef = databaseRef.child("allTasks").child(FIRAuth.auth()!.currentUser!.uid).childByAutoId()
        
        // ประกาศตัวแปร ไตเติ้ล กับ รายละเอียด
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
        
        let dateLabel = String(self.dateLabel.text!)
        
        
        let data = UIImageJPEGRepresentation(self.picNote.image!, 0.5)
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let postId = "\(FIRAuth.auth()!.currentUser!.uid)\(UUID().uuidString)"
        let imagePath = "postImages\(postId)/postPic.jpg"

        
        
        storageRef.child(imagePath).put(data!, metadata: metadata) { (metadata, error) in
            if error == nil {
                
                
                let todo = TodoList(title: title, content: content, username:FIRAuth.auth()!.currentUser!.displayName!, picNoteStringUrl: String(describing: metadata!.downloadURL()!) , userImageViewStringUrl: String(describing: FIRAuth.auth()!.currentUser!.photoURL!), postId: postId, dateLabel: dateLabel!)
                
                
               
                
                

                
                todoRef.setValue(todo.toAnyObject())
                
                
            }else {
                print(error!.localizedDescription)
            }
            
        }
        
        
        let  golistController = self.tabBarController?.viewControllers![1] as! UINavigationController
        ///กดเซฟแล้วเปลี่ยนหน้าเป็นหน้า list
        self.tabBarController?.selectedIndex = 1
        
    }

    
    
    
    
    
    
}
