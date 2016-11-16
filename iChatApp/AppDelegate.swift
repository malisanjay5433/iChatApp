//
//  AppDelegate.swift
//  iChatApp
//
//  Created by Pravin on 27/06/16.
//  Copyright © 2016 Sanjay. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor = UIColor.lightGray
            
            //UIColor(red: 65/255, green: 174/255, blue: 209/255, alpha: 0.0)
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
        FIRApp.configure()
        logUser()

//        window = UIWindow(frame:UIScreen.mainScreen().bounds)
//        window?.makeKeyAndVisible()
//        window?.rootViewController = UINavigationController(rootViewController:ViewController())
        
        UITextField.appearance().keyboardAppearance = .dark
//        let addStatusBar = UIView()
//        addStatusBar.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 20);
//        addStatusBar.backgroundColor = UIColor.grayColor()
//        self.window?.rootViewController?.view .addSubview(addStatusBar)
//      makeRootVc()
       return true
    }
    func makeRootVc(){
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: NewViewController())
        
    }
    func logUser(){
        if FIRAuth.auth()!.currentUser != nil {
//            
//           let tabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserViewController") as! UINavigationController
//            self.window?.rootViewController = tabBar
//            
            let messageController = MessageController()
            let navController = UINavigationController(rootViewController: messageController)
            self.window?.rootViewController = navController
        }
        
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
