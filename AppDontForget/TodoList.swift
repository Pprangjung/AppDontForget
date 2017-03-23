
//  TodoList.swift
//  AppDontForget
//
//  Created by Prang on 1/12/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


struct TodoList {
    var title:String!
    var content:String!
    var username:String!
    var dateLabel:String!
    var ref : FIRDatabaseReference?
    var key: String!
    var picNoteStringUrl : String!
    var userImageViewStringUrl : String!
    var postId: String!
    
    
    
    init(title:String,content:String,username:String,picNoteStringUrl : String,userImageViewStringUrl : String,postId: String,dateLabel:String,key:String="") {
        self.title=title
        self.content=content
        self.username = username
        self.dateLabel = dateLabel
        self.key=key
        self.userImageViewStringUrl = userImageViewStringUrl
        self.picNoteStringUrl = picNoteStringUrl
        self.postId = postId
        self.ref=FIRDatabase.database().reference()
    }
    
    init(snapshot:FIRDataSnapshot) {
       let value = snapshot.value as? [String: AnyObject]
          title = value?["title"] as! String
          content = value?["content"] as! String
          username = value?["username"] as! String
          postId = value?["postId"] as! String
          picNoteStringUrl = value?["picNoteStringUrl"] as! String
          userImageViewStringUrl = value?["userImageViewStringUrl"] as! String
          dateLabel = value?["dateLabel"] as! String
      
            key = snapshot.key
            ref = snapshot.ref
        
        
    }
    
    
    func toAnyObject() -> [String: AnyObject] {
        
        return ["title": title as AnyObject, "content": content as AnyObject,"username": username as AnyObject,"picNoteStringUrl":picNoteStringUrl as AnyObject,"userImageViewStringUrl": userImageViewStringUrl as AnyObject,"postId":postId as AnyObject,"dateLabel" : dateLabel as AnyObject]
    }
    
}
