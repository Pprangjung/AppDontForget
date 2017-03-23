//
//  NetworkService.swift
//  AppDontForget
//
//  Created by Prang on 1/11/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//



import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import UIKit


struct NetworkService {
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    
    
    // 3 เก็บข้อมุลลงดาต้าเบส
    fileprivate func saveInfo(_ user: FIRUser!, username: String, password: String){
        
        // สร้าง dic ที่จะเก็บค่ามีอะไรบ้าง
        
        let userInfo = ["email": user.email!, "username": username, "uid": user.uid, "photoUrl": String(describing: user.photoURL!)]
        
        // สร้างซับดาต้า อันหลักคือ user
        
        let userRef = databaseRef.child("users").child(user.uid)
        
        // เก็บข้อมูลที่เป็นค่าของ user  ทั้งหมดลง
        
        userRef.setValue(userInfo)
        
        
        // ล็อกอิน
        signIn(user.email!, password: password)
        
    }
    
    
    // 4 ฟังก์ชั่นล็อกอิน
    func signIn(_ email: String, password: String){
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                
                if let user = user {
                    
                    print("\(user.displayName!) has signed in succesfully!")
                    
                    
                    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDel.logUser()
                    
                    
                }
                
            }else {
                
                let alertView =  SCLAlertView()
                alertView.showError("😁OOPS😁", subTitle: error!.localizedDescription)
                
            }
        })
        
    }
    
    // 2 ข้อมูลผู้ใช้
    
    fileprivate func setUserInfo(_ user: FIRUser!, username: String, password: String,data: Data!){
        
        //สร้าง path เก็บภาพ
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        
        
        // pic ref
        
        let imageRef = storageRef.child(imagePath)
        
        // สร้าง metadata เพื่อเก็บภาพ
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        // เก็บภาพลง storage
        
        imageRef.put(data, metadata: metaData) { (metaData, error) in
            if error == nil {
                
                //ตอนโหลดในหน้า เซ็ทติ้ง
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData!.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    
                    if error == nil {
                        
                        self.saveInfo(user, username: username, password: password)
                        
                    }else{
                        print(error!.localizedDescription)
                        
                    }
                })
                
                
            }else {
                print(error!.localizedDescription)
                
            }
        }
        
}
    // ฟังก์ชั่นเซ็ทพลาสเวิร์ด
    func resetPassword(_ email: String){
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                print("An email with information on how to reset your password has been sent to you. thank You")
            }else {
                print(error!.localizedDescription)
                
            }
        })
        
    }
    
    // 1 ฟังก์ชั่นสมัครสมาชิก
    
    func signUp(_ email: String, username: String, password: String,data: Data!){
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error == nil {
                
                self.setUserInfo(user, username: username, password: password, data: data)
                
            }else {
                print(error!.localizedDescription)
                
            }
        })
        
        
    }
    
    
    
    
    
    
    
}
