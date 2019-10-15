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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
 
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        /// for testing
        //let launchedBefore = false
        let newTutorial = false
        
        if launchedBefore{
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Main" )
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
        }
        else
        {
            if newTutorial{
                self.window = UIWindow(frame: UIScreen.main.bounds)
                           
                               let storyboard = UIStoryboard(name: "ExtraTutorial", bundle: nil)
                                                                                                                     
                               let initialViewController = storyboard.instantiateViewController(withIdentifier: "p1" )
                               self.window?.rootViewController = initialViewController
            }
            else{
               // UserDefaults.standard.set(true, forKey: "launchedBefore")
                self.window = UIWindow(frame: UIScreen.main.bounds)
            
                let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
                                                                                                      
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "o1" )
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
            }
            
        }
      
     //   BugReporting.bugReportingOptions = [.]
//        Instabug.start(withToken: "17d71f8f957715dc419f961534032c20", invocationEvents: [.shake])
//        BugReporting.shakingThresholdForiPhone = 1.0
//        BugReporting.bugReportingOptions = [.emailFieldHidden]

        return true
    }
    
    /// set orientations you want to be allowed in this property by default
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }

    func applicationWillTerminate(_ application: UIApplication) {
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
                /* Typical reasons for an error here include:
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
}

