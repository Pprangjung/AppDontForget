//
//  DataServe.swift
//  AppDontForget
//
//  Created by Prang on 12/23/2559 BE.
//  Copyright © 2559 Prang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

class Datasevice{

    static let datasevice=Datasevice()
    private var _BASE_REF = FIRDatabase.database().reference()
    var BASE_REF:FIRDatabaseReference{
    return _BASE_REF
    
    }
    var storageRef: FIRStorageReference {
        
    return FIRStorage.storage().reference()
        
    }
    var fileUrl:String!
    
    
    
    func SignUp(username:String,email:String,password:String,data:NSData){
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user,Error)in
            if let Error=Error{
            print(Error.localizedDescription)
                return
            
            }
            guard let uid = user?.uid else{
                return
            }
            let ref = FIRDatabase.database().reference(fromURL:"https://adonttforget.firebaseio.com/") // ใส่ลิงค์เพื่อใส่ข้อมูลลงในfirebase
            let usersReference = ref.child("users").child(uid) //ใส่ซับดาต้าเบส
             let values = ["username":username,"email":email,"password":password]
            usersReference.updateChildValues(values,withCompletionBlock:{
                (err,ref)in
                if err != nil{
                    print(err)
                    return
                    
                }
                


            let changeRequest = user!.profileChangeRequest()
            changeRequest.displayName = username   
            changeRequest.commitChanges(){ (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                //เสร็จ เก็บค่าได้
                
        }
            
            
        let filePath = "profileImage/\(user!.uid)"
        let metadata = FIRStorageMetadata()
        metadata.contentType="image/jpeg"
            
            self.storageRef.child(filePath).put(data as Data, metadata: metadata,completion :{(metadata,Error)
                
                
                in
                if let Error=Error{
                    print(Error.localizedDescription)
                    return
                }
                self.fileUrl = metadata?.downloadURLs![0].absoluteString
                let changeRequestPhoto = user!.profileChangeRequest()
                changeRequestPhoto.photoURL = NSURL(string: self.fileUrl) as URL?
                changeRequestPhoto.commitChanges(completion: { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    } else {
                        
                        print("profile update")
                    }
                    
                })
                ProgressHUD.showSuccess("Success")
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
            
            })
            
        
        })

    })
    }
    
}
