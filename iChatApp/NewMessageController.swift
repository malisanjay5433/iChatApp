//
//  NewMessageController.swift
//  iChatApp
//
//  Created by Sanjay Mali on 15/11/16.
//  Copyright © 2016 Sanjay. All rights reserved.
//

import UIKit
import Firebase
class NewMessageController: UITableViewController {
    let cellId = "cellId"
    var users = [User]()
    var dataBaseRef: FIRDatabaseReference! {
        
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorage {
        return FIRStorage.storage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
       self.tableView.register(iChatUsersCell.self, forCellReuseIdentifier: cellId)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchUsers()
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

    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
   
    
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dictionary["name"] as? String
                }
                
                }, withCancel: nil)
        }
    }
    func handleLogout(){
        
        
    }
    func fetchUsers(){
        
        let usersRef = dataBaseRef.child("users")
        usersRef.observe(.value, with: { (snapshot) in
            var allUsers = [User]()
            for user in snapshot.children {
                
                //                print("user:\(user)")
                let myself = User(snapshot: user as! FIRDataSnapshot)
                //            if myself.username != FIRAuth.auth()?.currentUser?.displayName! {
                
                let u = FIRAuth.auth()?.currentUser
                let newUser = User(snapshot: user as! FIRDataSnapshot)
                allUsers.append(newUser)
                //                    self.users.append(newUser)
                //                }
                
            }
            
            self.users = allUsers
            DispatchQueue.main.async(){
                self.tableView.reloadData()
                print("No of users:\(self.users)")
            }
        }) { (error) in
            print("Error:\(error)")
            
    
    }
}
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! iChatUsersCell
        let user = self.users[indexPath.row]
        cell.textLabel?.text = user.username
        cell.detailTextLabel?.text = user.email
        cell.profileImageView.image = UIImage(named:"user_male_circle")
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
