//
//  historyTableViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 31/10/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "historyTableCell"

class historyTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var main: newMainViewController?
    
    var list: [Food]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alwaysBounceVertical = false
        loadItems()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier , for: indexPath) as! historyTableViewCell
        
        let record = list[indexPath.row]
        
        // put in safety
        
        cell.titleOfStatistic.text = record.name
        cell.valueOfStatistic.text = record.notes
        let fileToLoad = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(record.filename ?? "1.png")
        
        cell.displayContent(image: fileToLoad)

        
        if let date = record.date
        {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd MMM yy " //If you dont want static "UTC" you can go for ZZZZ instead of 'UTC'Z.
          // formatter.timeZone = TimeZone(abbreviation: "IST")
           let result1 = formatter.string(from: date)
           cell.dateTried.text = result1
        }
            
        switch record.type{
            case entryType.challenge.rawValue:
               // cell.backgroundColor = #colorLiteral(red: 0.9179692864, green: 0.4894329639, blue: 0.5481537275, alpha: 1)
                cell.badge.image = #imageLiteral(resourceName: "feat.png")
                    //UIColor(red: 186/255, green: 242/255, blue: 206/255, alpha: 1)
            case entryType.triedThisWeek.rawValue:
               // cell.backgroundColor = #colorLiteral(red: 0.9179692864, green: 0.5285187325, blue: 0.5605356174, alpha: 1)
                cell.badge.image = #imageLiteral(resourceName: "tried.png")
                //UIColor(red: 176/255, green: 235/255, blue: 206/255, alpha: 1)
            case entryType.triedBeforeThisWeek.rawValue:
               // cell.backgroundColor =  #colorLiteral(red: 0.8722069301, green: 0.5249428587, blue: 0.5436992209, alpha: 1)
            cell.badge.image = #imageLiteral(resourceName: "tried.png")
                //UIColor(red: 166/255, green: 230/255, blue: 206/255, alpha: 1)
            case entryType.target.rawValue:
                //cell.backgroundColor =  #colorLiteral(red: 0.8722069301, green: 0.4650338842, blue: 0.5208273163, alpha: 1)
                cell.badge.image = #imageLiteral(resourceName: "target.png")
                    //UIColor(red: 156/255, green: 225/255, blue: 206/255, alpha: 1)
            case entryType.targetCompleted.rawValue:
                //cell.backgroundColor =   #colorLiteral(red: 0.9254191518, green: 0.9255302548, blue: 0.9253813624, alpha: 1)
                cell.badge.image = #imageLiteral(resourceName: "target.png")
                //UIColor(red: 146/255, green: 220/255, blue: 206/255, alpha: 1)
            default: cell.badge.image = #imageLiteral(resourceName: "little dude1.png")
                //cell.backgroundColor =  UIColor(red: 136/255, green: 215/255, blue: 206/255, alpha: 1)

        }

                   
                    if indexPath.row.isMultiple(of: 2) == true{
                            cell.backgroundColor =  #colorLiteral(red: 0.9921568627, green: 0.3215686275, blue: 0.4666666667, alpha: 1)
                    }
                    else{
                            cell.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.5285187325, blue: 0.7176470588, alpha: 1)
                    }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            var thisIsATriedFood: Food?
                
            if list[indexPath.row].type == entryType.triedThisWeek.rawValue {
                thisIsATriedFood = list[indexPath.row]
            }
            else
            {
                thisIsATriedFood = nil
            }
            
            if bulkDelete == false{
                let alert = UIAlertController(title: "Are you sure?", message: "Deleting this record can't be undone", preferredStyle: .actionSheet)

                        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
                            //self.list.remove(at: indexPath.row)
                            
                            self.context.delete(self.list[indexPath.row])
                            self.list.remove(at: indexPath.row)
                            do{
                                try self.context.save()
                            } catch {
                                let nserror = error as NSError
                                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                            }
                            tableView.deleteRows(at: [indexPath], with: .fade)
                        }))
               
                    alert.addAction(UIAlertAction(title: "Delete & don't ask again today", style: .destructive, handler: {action in
                       
                        
                        self.context.delete(self.list[indexPath.row])
                        self.list.remove(at: indexPath.row)
                        do{
                            try self.context.save()
                        } catch {
                            let nserror = error as NSError
                            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                        }
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        bulkDelete = true
                    }))
                   
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                     self.present(alert, animated: true)
                }
                else{
                    
                    /// am i creting a bug by only deleting parent
                
                
                    context.delete(list[indexPath.row])
                    self.list.remove(at: indexPath.row)
                    do{
                        try context.save()
                    } catch {
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
        
            if thisIsATriedFood  != nil {
             
                guard let indexOfDeletedFood = main?.foodArray.index(of: thisIsATriedFood as! Tried) else { fatalError("couldn't find that food - are you sure its previously tried? ") }
                main?.foodArray.remove(at: indexOfDeletedFood)
                main?.myCollectionView.reloadData()
            }
        }
        
    }
    
    /// MARK: Setup
    func loadItems(){
        let request : NSFetchRequest<Food> = Food.fetchRequest()
        do{
            try list = context.fetch(request).reversed()
            }
        catch{
            print("Error fetching data \(error)")
            }
    }


    
 
}
