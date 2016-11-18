//
//  AuthenticationService.swift
//  WhatsAppClone
//
//  Created by Frezy Stone Mboumba on 7/20/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


struct AuthenticationService {
    
    var databaseRef: FIRDatabaseReference! {
        
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference! {
        
        return FIRStorage.storage().reference()
    }
    
    // 3 - We save the user info in the Database
    fileprivate func saveInfo(_ user: FIRUser!, username: String, password: String, country: String, biography: String){
        
        let userInfo = ["email": user.email!, "username": username, "country": country, "biography": biography, "uid": user.uid, "photoURL": String(describing: user.photoURL!)]
        
        let userRef = databaseRef.child("users").child(user.uid)
        
        userRef.setValue(userInfo)
        
        signIn(user.email!, password: password)
        
        
    }
    
    // 4 - We sign in the User
    func signIn(_ email: String, password: String){
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
              
                if let user = user {
                    
                    print("\(user.displayName!) has signed in successfuly")
                  
                    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDel.logUser()
                }
                
            }else {
                
//                let alertView =  SCLAlertView()
//                alertView.showError("😁OOPS😁", subTitle: error!.localizedDescription)
                 print("OOPS😁 Error")

                
            }
        })
        
    }
    
    // 1 - We create firstly a New User
    func signUp(_ email: String, username: String, password: String, country: String, biography: String, data: Data!){
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                
                self.setUserInfo(user, username: username, password: password, country: country, biography: biography, data: data)
                
                
            }else {
                
//                let alertView =  SCLAlertView()
//                alertView.showError("😁OOPS😁", subTitle: error!.localizedDescription)
                  print("OOPS😁 Error")

            }
        })
        
    }
    
    func resetPassword(_ email: String){
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                
                DispatchQueue.main.async(execute: { 
//                    let alertView =  SCLAlertView()
                    
                    print("Resetting Password An email containing the different information on how to reset your password has been sent to \(email)")
                })
                
                
                
            }else {
//                
//                let alertView =  SCLAlertView()
//                alertView.showError("😁OOPS😁", subTitle: error!.localizedDescription)
                print("OOPS😁 Error")

            }
        })
        
    }
    
    // 2 - We set the User Info
    fileprivate func setUserInfo(_ user: FIRUser!, username: String, password: String, country: String, biography: String, data: Data!){
        
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        
        let imageRef = storageRef.child(imagePath)
        
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.put(data, metadata: metadata) { (metadata, error) in
            if error == nil {
                
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                
                if let photoURL = metadata!.downloadURL(){
                    changeRequest.photoURL = photoURL
                }
                
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        
                        self.saveInfo(user, username: username, password: password, country: country, biography: biography)
                    }
                    else {
                        
                        print("OOPS😁 Error")
//                        let alertView =  SCLAlertView()
//                        alertView.showError("😁OOPS😁", subTitle: error!.localizedDescription)

                    }
                    
                })
            }else {
                
//                let alertView =  SCLAlertView()
//                alertView.showError("😁OOPS😁", subTitle: error!.localizedDescription)
                print("OOPS😁 Error")

                
            }
        }
        
        
    }
}
