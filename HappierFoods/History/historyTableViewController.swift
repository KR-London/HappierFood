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
    var historyArray: [History]?
    var foodArray: [Tried]!
    var challengeFoodsArray: [Challenge]!
    var targetsArray: [Target]!
    /// I need something more here to store information about badges and such
    
    var foods: [(String, String)]!
    
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
        
        cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        return cell
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
