//
//  AppDelegate.swift
//  MyMemory
//
//  Created by DAVY UONG on 8/19/15.
//  Copyright (c) 2015 DAVY UONG. All rights reserved.
//

import UIKit
import Parse
import ParseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // Set up the Parse SDK
        Parse.setApplicationId("A3eZq4C4jbLEd7K8fCQxO7d8bA1MrfFyOvLPjEyM", clientKey: "9t0ZLFO4SaEOnfgc6fJgkFAXKK8ayd0OZjFWlsgS")
        
        //Allows public read access - any user can see all objects created with this default ACL
        //Only provides write access to the user that created the object
        let acl = PFACL()
        acl.setPublicReadAccess(false)
        PFACL.setDefaultACL(acl, withAccessForCurrentUser: true)
        
        loginSetup()
        
        UINavigationBar.appearance().barTintColor = StyleConstants.defaultBlueColor
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().translucent = false
        
        UIToolbar.appearance().barTintColor = StyleConstants.defaultBlueColor
        UIToolbar.appearance().tintColor = UIColor.whiteColor()
        UIToolbar.appearance().translucent = false
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

//MARK: PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate
extension AppDelegate: PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    //MARK: Parse Login
    
    func loginSetup() {
        let user = PFUser.currentUser()
        let startViewController: UIViewController
        
        if user != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            startViewController = storyboard.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
        }
        else {
            var logInViewController = PFLogInViewController()
            logInViewController.delegate = self
            var signUpViewController = PFSignUpViewController()
            signUpViewController.delegate = self
            logInViewController.signUpController = signUpViewController
            
            startViewController = logInViewController
        }
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = startViewController
        self.window?.makeKeyAndVisible()
    }
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if (!username.isEmpty || !password.isEmpty) {
            return true
        }
        else {
            return false
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        loginSetup()
        //self.window.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("\nFailed to login!")
    }
    
    //MARK: Parse Signup
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        loginSetup()
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("\nFailed to signup!")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        print("\nUser dismissed signup!")
    }
}

