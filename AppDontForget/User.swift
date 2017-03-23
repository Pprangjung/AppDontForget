//
//  User.swift
//  AppDontForget
//
//  Created by Prang on 1/12/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct User {
    
    var username: String!
    var email:String!
    var photoUrl:String!
    var uid: String!
    var ref: FIRDatabaseReference?
    var key:String
    
    //ติดบั๊กตอนสมัครเข้ามาอ้ากกกก
    init(snapshot:FIRDataSnapshot) {
    let values = snapshot.value as! [String : AnyObject]
         key = snapshot.key
         username =  values["username"] as! String
         email = values["email"]as! String
         photoUrl = values["photoUrl"] as! String
          uid = values["uid"] as? String
         ref = snapshot.ref
        
    }
    func toAnyObject() -> Any {
        return [
           "username" : username,
            "email": email,
            "photoUrl": photoUrl,
            "uid": uid
        ]
    }
    
    
    }
