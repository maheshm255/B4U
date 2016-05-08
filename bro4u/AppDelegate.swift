//
//  AppDelegate.swift
//  bro4u
//
//  Created by Mahesh Bajaj
//  Copyright (c) All rights reserved.
//

import UIKit
import CoreData
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.registerPushNotification()
        self.checkUserAlreadyLogin()
        
        
        
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
        
        FBSDKAppEvents.activateApp()
        
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        //  self.saveContext()
    }
    
    
    // MARK: - Push Notification
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Failed to register with error: \(error)");
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for i in 0..<deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        print("tokenString: \(tokenString)")        
       // device_id=34234234&gcm_id=23434fser34f&token_request=alsdkfjaklsdjf&device_type=2
        
        let tokenReques = ""
        let params = "?device_id=\(b4u_Utility.getUUIDFromVendorIdentifier())&gcm_id=\(tokenString)&token_request=\(tokenReques)&device_type=2"
        b4u_WebApiCallManager.sharedInstance.getApiCall(kRegisterPushToken, params:params, result:{(resultObject) -> Void in
            
            
             if resultObject as! String == "Success"
             {
                print("Device Token registered successfully")
             }else{
                print("Device Token registered Failed")

            }
        })
        
        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void)
        
    {
        print("Recived: \(userInfo)")
        
        switch application.applicationState
        {
        case  UIApplicationState.Active:
            if  userInfo["type"]?.intValue == 1
            {
                print("News Module Push Notification")
            }
            if  userInfo["type"]?.intValue == 2
            {
                print("Case Managment Module Push Notification")
            }
            print("active")
        case  UIApplicationState.Background:
            print("background")
        case  UIApplicationState.Inactive:
            print("inactive")
            
        }
        
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.applearn.bro4u" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("bro4u", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func application(application: UIApplication,
                     openURL url: NSURL,
                             sourceApplication: String?,
                             annotation: AnyObject) -> Bool {
        let urlString:String = url.absoluteString
        if urlString.lowercaseString.rangeOfString("com.googleusercontent.apps.") != nil{
            return GIDSignIn.sharedInstance().handleURL(url,
                                                        sourceApplication: sourceApplication,
                                                        annotation: annotation)
        }
        else
        {
            return FBSDKApplicationDelegate.sharedInstance().application(
                application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
            
        }
        
    }
    
    
    func checkUserAlreadyLogin()
    {
        let isUserLoggedIn =   NSUserDefaults.standardUserDefaults().objectForKey("isUserLogined")
        
        if let hasLogin:Bool = isUserLoggedIn as? Bool
        {
            if hasLogin
            {
                
                if let unarchivedObject =
                    
                    NSUserDefaults.standardUserDefaults().objectForKey("loginInfo") as? NSData
                {
                    bro4u_DataManager.sharedInstance.loginInfo =   NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as? b4u_LoginInfo
                }
            }
        }
    }
    
    
    func registerPushNotification()
    {
        let setting =   UIUserNotificationSettings(forTypes:[UIUserNotificationType.Badge,UIUserNotificationType.Sound,UIUserNotificationType.Alert], categories:nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(setting)
        
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
       
    
}

