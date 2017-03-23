//
//  SendText.swift
//  AppDontForget
//
//  Created by Prang on 3/19/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct SendText {

    var text: String!
    var toId : String!
    var fromId : String!
    var ref: FIRDatabaseReference?
    var key: String!
 


  init (text: String , toId : String  ,fromId : String,key: String = ""){
   self.text = text
   self.toId = toId
   self.fromId = fromId
   self.key = key
   self.ref = FIRDatabase.database().reference()

}

    init(snapshot : FIRDataSnapshot) {
        let value = snapshot.value as? [String: AnyObject]
        text = value?["text"] as! String
        toId  = value?["toId"] as! String
        fromId = value?["fromId"] as! String
        self.key = snapshot.key
        self.ref = snapshot.ref

    }
   
    func toAnyObject() -> [String: AnyObject] {
    
    return["text":text as AnyObject,"toId":toId as AnyObject,"fromId":fromId as AnyObject]
    }
    
}
