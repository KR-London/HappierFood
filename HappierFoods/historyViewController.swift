//
//  historyViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 06/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import CoreData

class historyViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var food: [NSManagedObject] = []
    var historyArray: [HistoryTriedFoods]!

    @IBOutlet weak var resetToNewWeek: UIButton!
    
    @IBOutlet weak var clearAllData: UIButton!
    
    @IBAction func cacheWeek(_ sender: UIButton) {
        copyFoodToHistory()

        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func clearData(_ sender: Any) {
        
        weak var main = navigationController?.viewControllers[0] as? mainViewController
        main?.deleteAllData("TargetFood")
        main?.deleteAllData("TriedFood")
        deleteAllData("HistoryTriedFoods")
        
        main?.foodArray = []
        main?.targetArray = []
        historyArray = []
        defaults.set(0.0, forKey: "Last Week Started")
        
        DispatchQueue.main.async{
            main?.mainCollectionView.reloadData()
             main?.mainCollectionView.reloadInputViews()

        }
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func saveItems(){
            do{ try
                context.save() }
            catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                
            }
    }
        
    func copyFoodToHistory(){
        
        weak var main = navigationController?.viewControllers[0] as? mainViewController
        let size = main?.foodArray.count ?? -1
        
        if size >  0 {
            for i in 0 ... size - 1 {
                let foodToMove = main?.foodArray[i]
                if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                    let menuItem = NSEntityDescription.insertNewObject(forEntityName: "HistoryTriedFoods", into: managedObjectContext) as! HistoryTriedFoods
                    menuItem.filename = foodToMove?.filename
                    menuItem.name = foodToMove?.name
                    menuItem.rating = foodToMove?.rating ?? 0
                    menuItem.dateTried = foodToMove!.dateTried
                    saveItems()
                }
            }
        }
         
            main?.cacheData()
    }
    
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
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    deinit{
        print("OS reclaiming memory from history view")
    }
}
