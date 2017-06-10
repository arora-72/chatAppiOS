//
//  dbProvider.swift
//  chat app firebase
//
//  Created by arora_72 on 11/06/17.
//  Copyright © 2017 indresh arora. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage


class dbProvider{
    
    static let _instance = dbProvider();//an object of the class created
    
    private init(){}//enables to let no other class create object of this class (dbProvider)
        
        static var Instance : dbProvider{
            return _instance
        }
    
    
    var dbRef: FIRDatabaseReference{
        
        return FIRDatabase.database().reference();
    }
    
    
    var contactsRef: FIRDatabaseReference{
        return dbRef.child(Constants.CONTACTS)
    }
    
    var mediaMessageRef: FIRDatabaseReference{
        return dbRef.child(Constants.MEDIA_MESSAGES)
    }
    
    var storageRef: FIRStorageReference{
        return FIRStorage.storage().reference(forURL: "gs://chatapp-firebase-awesome-tuts.appspot.com")
    }
    
    var imageStorageRef: FIRStorageReference{
        return storageRef.child(Constants.IMAGE_STORAGE)
    }
   
    
    var videoStorageRef: FIRStorageReference{
        return storageRef.child(Constants.VIDEO_STORAGE)
    }
    
    
    func saveUser(withID: String, email: String, password: String){
        
        let data: Dictionary<String,Any> = [Constants.EMAIL: email,Constants.PASSWORD: password];
        
        contactsRef.child(withID).setValue(data);
        
        
    }
    
    
    
    
}//class


