//
//  UserViewController.swift
//  iChatApp
//
//  Created by Sanjay Mali on 09/07/16.
//  Copyright © 2016 Sanjay. All rights reserved.
//

import UIKit
import Firebase

class UserViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    var users = [User]()
    var dataBaseRef: FIRDatabaseReference! {
        
     return FIRDatabase.database().reference()
 }

    var storageRef: FIRStorage {
    return FIRStorage.storage()
  }

    override func viewDidLoad() {
        super.viewDidLoad()
//        let image = UIImage(named: "chat")
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
//        self.tableView.rowHeight = 80
//        self.tableView.dataSource  = self
//        self.tableView.delegate = self
//        self.view.backgroundColor =  UIColor(hexString: "#4875B4")
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",style: .plain,target: self,action: #selector(handleLogut))
//        if FIRAuth.auth()?.currentUser?.uid == nil{
//            perform(#selector(handleLogut), with: nil,afterDelay: 0)
//        }
 
    }
    func handleNewMessage() {
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    func handleLogut() {
        
        do{
            try FIRAuth.auth()?.signOut()
            
        }catch let logoutError{
            print(logoutError)
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
//        let usersRef = dataBaseRef.child("users")
//        usersRef.observe(.value, with: { (snapshot) in
//            var allUsers = [User]()
//            for user in snapshot.children {
//                
////                print("user:\(user)")
//            let myself = User(snapshot: user as! FIRDataSnapshot)
////            if myself.username != FIRAuth.auth()?.currentUser?.displayName! {
//                
//                   let u = FIRAuth.auth()?.currentUser
//                 self.navigationItem.title = u?.email
//                     print("from CurrentUser:\(u?.email)")
//                    let newUser = User(snapshot: user as! FIRDataSnapshot)
//                    allUsers.append(newUser)
////                    self.users.append(newUser)
////                }
//                
//            }
//           
//            self.users = allUsers
//            DispatchQueue.main.async(){
//            self.tableView.reloadData()
//            print("No of users:\(self.users)")
//            }
//        }) { (error) in
//         print("Error:\(error)")
//        
//        }
        
    }

    
//    func handleLogut() {
//        
//        do{
//            try FIRAuth.auth()?.signOut()
//            
//        }catch let logoutError{
//            print(logoutError)
//        }
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//       self.present(vc, animated: true, completion: nil)
//    }
//    
   }
