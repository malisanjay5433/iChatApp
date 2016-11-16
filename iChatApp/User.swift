//
//  User.swift
//  WhatsAppClone
//
//  Created by Frezy Stone Mboumba on 7/21/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct User {
    
    var username: String!
    var email: String!
//    var country: String!
//    var photoURL: String!
//    var biography: String!
//    var uid: String!
    var ref: FIRDatabaseReference?
    var key: String
    
    init(snapshot: FIRDataSnapshot){

        let value = snapshot.value as? NSDictionary
//        print("Value:\(value)")
        key = snapshot.key
        ref = snapshot.ref
        self.username = value?["name"] as! String
        self.email = value?["email"] as! String
        
        print("key,Ref:\(key,ref)")
        print("UserName:\(self.username)")
//        country = value?["country"] as! String
//        biography = value?["biography"] as! String
//        photoURL = value?["photoURL"] as! String
//        uid = value?["uid"] as? String

    }
}
