//
//  iChatMessagesController.swift
//  iChatApp
//
//  Created by Sanjay Mali on 17/11/16.
//  Copyright © 2016 Sanjay. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class iChatMessagesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 75
        self.tableView.tableFooterView = UIView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        let image = UIImage(named: "new_message_icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        checkIfUserIsLoggedIn()
    }
    
    func handleNewMessage() {
        let newMessageController = iChatNewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
               let inst = FIRAuth.auth()?.currentUser
               print("uid:\(FIRAuth.auth()?.currentUser?.email)")
              FIRDatabase.database().reference().child("users").child(inst!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                self.navigationItem.title = inst?.email

//                if let dictionary = snapshot.value as? [String: AnyObject] {
//                }
                
            }, withCancel: nil)
        }
    }
    
    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = iChatLoginController()
        present(loginController, animated: true, completion: nil)
    }
    

}
