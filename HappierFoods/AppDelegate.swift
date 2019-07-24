//
//  AppDelegate.swift
//  HappierFoods
//
//  Created by Kate Roberts on 04/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import CoreData
import Instabug
//import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        /// for testing
       // let launchedBefore = false
        
        if launchedBefore{
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Main" )
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
        }
        else
        {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
                                                                                                      
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "o1" )
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
        }
//        
      //    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:  UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )!]
        if let customFont = UIFont(name: "TwCenMT-CondensedExtraBold", size: 20 ) {
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .normal)
        }
       
        //UIBarButtonItem.appearance().titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.orange]
//        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 233, green: 2, blue: 3, alpha: 1.0)]
//        UINavigationBar.appearance().titleTextAttributes = textAttributes
//       // registerForPushNotifications()
    
      
       // BugReporting.bugReportingOptions = [.]
     Instabug.start(withToken: "17d71f8f957715dc419f961534032c20", invocationEvents: [.shake])
        
        BugReporting.shakingThresholdForiPhone = 1.0
        BugReporting.bugReportingOptions = [.emailFieldHidden]
        //view.instabug_privateView = true
        
        return true
    }
    
    /// set orientations you want to be allowed in this property by default
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
 


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "HappierFoods")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
//    func registerForPushNotifications(){
//
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ [weak self] granted, error in
//
//            print("Permission granted: \(granted)")
//            guard granted else {return}
//            self?.getNotificationSettings()
//
//        }
//    }
    
//    func getNotificationSettings(){
//        UNUserNotificationCenter.current().getNotificationSettings{settings in
//            print("Notification settings: \(settings)")
//
//            guard settings.authorizationStatus == .authorized else {return}
//
//            DispatchQueue.main.async {
//                UIApplication.shared.registerForRemoteNotifications()
//            }
//        }
//    }
//
//    func application( _ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
//        let tokenParts = deviceToken.map {data in String(format: "%02.2hhx", data)}
//        let token = tokenParts.joined()
//        print("Device Token: \(token)")
//    }
//
//    func application( _ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error){
//        print("Failed to register: \(error)")
//    }
}

