//
//  AppDelegate.swift
//  HappierFoods
//
//  Created by Kate Roberts on 04/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        /// for testing
        doIPlaceANewDatestamp()
        //let launchedBefore = false
        let newTutorial = false
        
        if launchedBefore{
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "testNav" )
            self.window?.rootViewController = initialViewController
            
               //   let nextViewController = storyboard.instantiateViewController(withIdentifier: "newDataInputViewController" )
            //self.window?.rootViewController!.push(nextViewController, animated: true, completion: nil)
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
                                                                                                      
                //let initialViewController = storyboard.instantiateViewController(withIdentifier: "o1" )
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "o1" )
           
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
            }

        }
      
     //   BugReporting.bugReportingOptions = [.]
//        Instabug.start(withToken: "17d71f8f957715dc419f961534032c20", invocationEvents: [.shake])
//        BugReporting.shakingThresholdForiPhone = 1.0
//        BugReporting.bugReportingOptions = [.emailFieldHidden]
        
        UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = UIColor(red: 3/255, green: 18/255, blue: 8/255, alpha: 1)
        let navigationBarAppearace = UINavigationBar.appearance()

      //  navigationBarAppearace.tintColor = UIColor(red: 3/255, green: 18/255, blue: 8/255, alpha: 1)
      //  navigationBarAppearace.barTintColor = UIColor(red: 3/255, green: 18/255, blue: 8/255, alpha: 1)

        // change navigation item title color
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
          
    
        return true
    }
    
//    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//          if(event?.subtype == UIEvent.EventSubtype.motionShake) {
//                  print("You shook me, now what")
//              }
//    }
//
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
    
    func doIPlaceANewDatestamp(){
        let now = Date()
        print(Date())
        var loginRecord = UserDefaults.standard.object(forKey: "loginRecord") as? [ Date ] ?? [ Date ]()
        print("login record")
        print(loginRecord)
        
        loginRecord = loginRecord + [now]
        UserDefaults.standard.set(loginRecord, forKey: "loginRecord")
        
//        if let lastStamp = loginRecord.popLast()
//        {
//            if Calendar.current.isDateInToday(lastStamp)
//            {
//                loginRecord = loginRecord + [now]
//                UserDefaults.standard.set(loginRecord, forKey: "loginRecord")
//            }
//        }
        
        
        
    }
}

