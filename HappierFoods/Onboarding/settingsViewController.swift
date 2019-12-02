//
//  settingsViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 31/10/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import CoreData

class settingsViewController: UIViewController {
    
     // MARK: Core Data variables
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     var food: [NSManagedObject] = []
     var foodArray: [Tried]?
     var targetArray: [Target]?
     var historyArray: [History]?
     var logons: [Logons]!
    
    @IBAction func cacheData(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you sure?", message: "This will move your tries to 'history' and start again with a new 'week'.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Save & reset week", style: .destructive, handler: {action in
             self.cacheData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    @IBAction func deleteAll(_ sender: Any) {
        
       let alert = UIAlertController(title: "Are you sure?", message: "This will delete ALL of your data.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Delete All", style: .destructive, handler: {action in
             self.deleteAllData("Target")
             self.deleteAllData("Tried")
             self.deleteAllData("History")
             self.deleteAllData("Logons")
            
            UserDefaults.standard.removeObject(forKey: "loginRecord")
             self.returnToMain()
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /// MARK: Delete and archive functions
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        }
        catch let error {
            print("Delete all data in \(entity) error :", error)
        }
    }
    
    func cacheData(){
        
        loadItems()
        
        //let maximumSaveNumber = historyArray?.compactMap({$0.saveNumber}).max() ?? 0

        let size = foodArray?.count ?? -1
        
        if size >  0 {
            for i in 0 ... size - 1 {
                let foodToMove = foodArray?[i]
                if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                    let menuItem = NSEntityDescription.insertNewObject(forEntityName: "History", into: managedObjectContext) as! History
                    menuItem.filename = foodToMove?.filename
                    menuItem.name = foodToMove?.name
                    menuItem.rating = foodToMove?.rating ?? 0
                    menuItem.type = entryType.triedBeforeThisWeek.rawValue
                    saveItems()
                }
            }
        }
        
        deleteAllData("Tried")
        
        /// reset markers
        let dateNow = Date().timeIntervalSince1970
        defaults.set(dateNow, forKey: "Last Week Started")
        defaults.set(false, forKey: "Celebration Status")
       
        weak var main = navigationController?.viewControllers[0] as? newMainViewController
        
        main?.foodArray = []
        main?.targetArray = []

        DispatchQueue.main.async{
            main?.myCollectionView.reloadData()
            main?.myCollectionView.reloadInputViews()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func saveItems(){
            do{ try
                context.save() }
            catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                
            }
    }
        
    
    func returnToMain(){
        weak var main = navigationController?.viewControllers[0] as? newMainViewController
        
        main?.foodArray = []
        main?.targetArray = []

        defaults.set(0.0, forKey: "Last Week Started")
        defaults.set(false, forKey: "Celebration Status")
        UserDefaults.standard.set(false, forKey: "launchedBefore")
       DispatchQueue.main.async{
            main?.myCollectionView.reloadData()
            main?.myCollectionView.reloadInputViews()
       }
        navigationController?.popViewController(animated: true)
    }
    
        func loadItems(){
            let request : NSFetchRequest<Tried> = Tried.fetchRequest()
            do{
                try foodArray = context.fetch(request)
            }
            catch{
                print("Error fetching data \(error)")
            }
        }
    

}
