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
   // var historyArray: [History]?
  //  var foodArray: [Tried]!
   // var challengeFoodsArray: [Challenge]!
   // var targetsArray: [Target]!
    /// I need something more here to store information about badges and such
    
    //var foods: [(String, String)]!
    
    var main: newMainViewController?
    
    var list: [Food]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // must also include the list of badges
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier , for: indexPath) as! statsTableViewCell
        
        let record = list[indexPath.row]
        
        cell.titleOfStatistic.text = record.name
        //cell.imageForStat.image =  UIImage(named: foods[indexPath.row].1)
        
        //cell.displayContent(image: foods[indexPath.row].1)
        let fileToLoad = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(record.filename ?? "1.png")
        
        cell.displayContent(image: fileToLoad)
        cell.imageView?.layer.cornerRadius = 5.0
        cell.imageView?.clipsToBounds = true
       // print(foods[indexPath.row].1)
        cell.imageView?.cornerRadius = 5.0
        
        cell.valueOfStatistic.text = ""
        
        switch record.type{
            case entryType.challenge.rawValue:
                cell.backgroundColor = #colorLiteral(red: 0.338232398, green: 0.2534516156, blue: 0.3303070068, alpha: 1)
                    //UIColor(red: 186/255, green: 242/255, blue: 206/255, alpha: 1)
            case entryType.triedThisWeek.rawValue:
                cell.backgroundColor = #colorLiteral(red: 0.7630795836, green: 0.8484307528, blue: 0.5961778164, alpha: 1)
                //UIColor(red: 176/255, green: 235/255, blue: 206/255, alpha: 1)
            case entryType.triedBeforeThisWeek.rawValue:
                cell.backgroundColor =  #colorLiteral(red: 0.4955835342, green: 0.6332069039, blue: 0.4178404212, alpha: 1)
                //UIColor(red: 166/255, green: 230/255, blue: 206/255, alpha: 1)
            case entryType.target.rawValue:
                cell.backgroundColor =  #colorLiteral(red: 0.3476209641, green: 0.4364097714, blue: 0.3838276267, alpha: 1)
                    //UIColor(red: 156/255, green: 225/255, blue: 206/255, alpha: 1)
            case entryType.targetCompleted.rawValue:
            cell.backgroundColor =   #colorLiteral(red: 0.9254191518, green: 0.9255302548, blue: 0.9253813624, alpha: 1)
                //UIColor(red: 146/255, green: 220/255, blue: 206/255, alpha: 1)
            default: cell.backgroundColor =  UIColor(red: 136/255, green: 215/255, blue: 206/255, alpha: 1)
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
                    let alert = UIAlertController(title: "Are you sure?", message: "Deleting this record can't be undone", preferredStyle: .alert)

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
               
                    alert.addAction(UIAlertAction(title: "Delete & don't ask again", style: .destructive, handler: {action in
                       
                        
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
//                main?.myCollectionView.cellForItem(at:  IndexPath(row: indexOfDeletedFood, section: 0))
//                main?.loadItems()
//                //main?.myCollectionView.reloadSections([0])
//              // main?.myCollectionView.reloadData()
               main?.myCollectionView.reloadSections([0])
                //let index = IndexPath(
               // let cell = main?.myCollectionView.cellForItem(at: IndexPath(row: indexOfDeletedFood, section: 0)) as! mainCollectionViewCell
               // cell.cellImage = nil
               // cell.instructionReminder.isHidden = true

               // cell.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
                //cell.reloadInputViews()
               // main?.reloadInputViews()
                //main?.myCollectionView.
                
            }
        }
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /// MARK: Setup
    func loadItems(){
        let request : NSFetchRequest<Food> = Food.fetchRequest()
        do{
            try list = context.fetch(request)
        }
        catch{
            print("Error fetching data \(error)")
        }
//
//        let request2 : NSFetchRequest<Tried> = Tried.fetchRequest()
//        do{
//            try foodArray = context.fetch(request2)
//        }
//        catch{
//            print("Error fetching data \(error)")
//        }
//
//        let request3 : NSFetchRequest<Target> = Target.fetchRequest()
//             do{
//                 try targetsArray = context.fetch(request3)
//             }
//             catch{
//                 print("Error fetching data \(error)")
//             }
//
//        let request4 : NSFetchRequest<Challenge> = Challenge.fetchRequest()
//             do{
//                 try challengeFoodsArray = context.fetch(request4)
//             }
//             catch{
//                 print("Error fetching data \(error)")
//             }
        }


    
 
}
