//
//  ViewController.swift
//  iChatApp
//
//  Created by Pravin on 27/06/16.
//  Copyright © 2016 Sanjay. All rights reserved.
//

import UIKit
import Firebase
import Spring

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var emailTextFiled:DesignableTextField!
    @IBOutlet weak var passwordTextFiled:DesignableTextField!
    @IBOutlet weak var login:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextFiled.delegate = self
        self.passwordTextFiled.delegate = self
        self.emailTextFiled.text = "ichat@gmail.com"
        self.passwordTextFiled.text = "123456"
        
        
//        self.view.backgroundColor =  UIColor(hexString: "#4875B4") //UIColor(r: 0,g: 119,b: 181)
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out" ,style:.Plain ,target: self, action: #selector(handleSignOut))
        configure()
        login.addTarget(self, action: #selector(handleLogin),
                        for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func configure(){
        emailTextFiled.layer.cornerRadius = 3.0
        emailTextFiled.layer.masksToBounds = true
        passwordTextFiled.layer.cornerRadius = 3.0
        passwordTextFiled.layer.masksToBounds = true
        login.layer.cornerRadius = 3.0
        login.layer.masksToBounds = true
        
    }
    
    
    func handleLogin(){
        guard let email = emailTextFiled.text, let pass = passwordTextFiled.text else {
            print("Not valid ")
            return
        }
        if email == ""{
            emailTextFiled.animation = "shake"
            emailTextFiled.animate()
        }
        else if  pass == "" {
            passwordTextFiled.animation = "shake"
            passwordTextFiled.animate()
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
            
            
        if error != nil{
            print(error)
            return
            }
            print("Here")
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserViewController") as! UINavigationController
//            self.navigationController?.present(vc, animated: true, completion: nil)
    //        let loginController = UserViewController()
    //        self.present(loginController, animated: true, completion: nil)
//            let window = UIApplication.shared.window
//            var window:UIWindow = UIApplication.shared.delegate!.window!!
//            window = UIWindow(frame: UIScreen.main.bounds)
//            window.makeKeyAndVisible()
//            window.rootViewController = UINavigationController(rootViewController: UserViewController())
//            let window:UIWindow = UIApplication.shared.delegate!.window!!
//            let vc = self.storyboard!.instantiateViewController(withIdentifier: "UserViewController") as! UINavigationController
//            window.rootViewController = vc
//            let _ = self.navigationController?.popToRootViewController(animated: true)
            let newMessageController = MessageController()
            let navController = UINavigationController(rootViewController: newMessageController)
            self.present(navController, animated: true, completion: nil)
            
        })
    }
    
}
