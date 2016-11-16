//
//  RegisterViewController.swift
//  iChatApp
//
//  Created by Sanjay Mali on 09/07/16.
//  Copyright © 2016 Sanjay. All rights reserved.
//

import UIKit
import Firebase
import Spring

class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var emailTextFiled:DesignableTextField!
    @IBOutlet weak var passwordTextFiled:DesignableTextField!
    @IBOutlet weak var nameTextFiled:DesignableTextField!
    
    @IBOutlet weak var login:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextFiled.delegate = self
        self.passwordTextFiled.delegate = self
        self.nameTextFiled.delegate = self
        configure()
        self.view.backgroundColor =  UIColor(hexString: "#4875B4") //UIColor(r: 0,g: 119,b: 181)
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out" ,style:.Plain ,target: self, action: #selector(handleSignOut))
        login.addTarget(self, action: #selector(handleLogin),
                        for: .touchUpInside)
    }
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    func configure(){
        nameTextFiled.layer.cornerRadius = 3.0
        nameTextFiled.layer.masksToBounds = true
        emailTextFiled.layer.cornerRadius = 3.0
        emailTextFiled.layer.masksToBounds = true
        passwordTextFiled.layer.cornerRadius = 3.0
        passwordTextFiled.layer.masksToBounds = true
        login.layer.cornerRadius = 3.0
        login.layer.masksToBounds = true
        
    }
    
    
    func handleLogin(){
        
        
        guard let email = emailTextFiled.text, let password = passwordTextFiled.text,let name = nameTextFiled.text else {
            print("Not valid ")
            return
        }
        
        if  name == "" {
            
            nameTextFiled.animation = "shake"
            nameTextFiled.animate()
            
        }
        

        else if email == ""{
//            
//            let alert=UIAlertController(title: "", message: "Please enter all the info.", preferredStyle: UIAlertControllerStyle.alert);
//            //default input textField (no configuration...)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: {(action:UIAlertAction) in
//                
//            }))
//            self.present(alert, animated: true, completion: nil);
            emailTextFiled.animation = "shake"
            emailTextFiled.animate()
            
        } else if password == ""{
            passwordTextFiled.animation = "shake"
            passwordTextFiled.animate()
            
    
        }
        
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user:FIRUser?,error) in
            if error != nil {
                print(error)
                return
            }
            
            //Successfully Auth
            guard let uid = user?.uid else{
                return
                
            }
            
            let ref = FIRDatabase.database().reference(fromURL: "https://ichatapp-803f6.firebaseio.com/")
            let userRef = ref.child("users").child(uid)
            let values = ["name":name,"email":email]
            userRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
                
                
                if error != nil{
                    let alert=UIAlertController(title: "FAILURE", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert);
                    //default input textField (no configuration...)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: {(action:UIAlertAction) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    print(error?.localizedDescription)
                    return
                }
//                let alert=UIAlertController(title: "SUCCESS", message: "You're registered with us.", preferredStyle: UIAlertControllerStyle.Alert);
//                //default input textField (no configuration...)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: {(action:UIAlertAction) in
//                    
//                }))
//                self.presentViewController(alert, animated: true, completion: nil);
                self.dismiss(animated: true, completion: nil)
                
            })
            
            
        })
        
        
        
        
    }
    
    
    
    
}
