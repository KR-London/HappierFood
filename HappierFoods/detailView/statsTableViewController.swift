//
//  statsTableViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 30/10/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import CoreData
import Darwin

private let reuseIdentifier = "statsTableCell"

class statsTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var historyArray: [HistoryTriedFoods]?
    var foodArray: [TriedFood]!
    var logons: [Logons]!
    
    var loginRecord = UserDefaults.standard.object(forKey: "loginRecord") as? [ Date ] ?? [ Date ]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)  as! statsTableViewCell

        switch indexPath.row{
              case 0:
                  cell.titleOfStatistic.text = "Total Tries"
                  cell.valueOfStatistic.text = String( (historyArray?.count ?? 0) + (foodArray?.count ?? 0) )
              case 1:
                  cell.titleOfStatistic.text = "Total Foods Tried"
              case 2:
                  cell.titleOfStatistic.text = "All Logons"
                  cell.valueOfStatistic.text = String( loginRecord.count)
//                case 3:
//                   cell.titleOfStatistic.text = "Days logged on"
//                   cell.valueOfStatistic.text = String( loginRecord.count)
              case 3:
                  cell.titleOfStatistic.text = "Average Logon per week"
                  cell.valueOfStatistic.text = String( loginRecord.count/numberOfWeeks() )
              case 4:
                  cell.titleOfStatistic.text = "Average Tries Per Week"
              case 5:
                  cell.titleOfStatistic.text = "Most Retried Food"
              case 6:
                  cell.titleOfStatistic.text = "Count Pond Fish (< 5 Tries)"
              case 7:
                  cell.titleOfStatistic.text = "Count Lake Fish (< 12 Tries)"
              case 8:
                  cell.titleOfStatistic.text = "Count Sea Fish (> 12 Tries)"
              default:
                  cell.titleOfStatistic.text = " "
          }
          
          cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        return cell
    }
    
    
    func distinctDaysLoggedIn(){
//        var text = String()
//        var streak = 1
//        var streaking = true
//        var dateBefore = Date()
//
//        while streaking == true
//        {
//            if loginRecord.count > 0
//            {
//                let nextDateToCheck = loginRecord.popLast()!
//                if Calendar.current.isDate(dateBefore.addingTimeInterval(86400), inSameDayAs: nextDateToCheck) || Calendar.current.isDate(dateBefore, inSameDayAs: nextDateToCheck)
//                {
//                    loginRecord = loginRecord.dropLast()
//                    dateBefore = nextDateToCheck
//                    if Calendar.current.isDate(dateBefore.addingTimeInterval(86400), inSameDayAs: nextDateToCheck)
//                    {
//                        streak = streak + 1
//                    }
//                }
//                else
//                {
//                    streaking = false
//                }
//            }
//            else
//            {
//                streaking = false
//            }
    }
    
    func numberOfWeeks() -> Int{
        var numberOfDays = Calendar.current.dateComponents([.day], from: loginRecord.first ?? Date(), to: loginRecord.last ?? Date()).day
        print(numberOfDays)
        
        if numberOfDays == 0 || numberOfDays == nil {numberOfDays = 1}
        print(numberOfDays)
        return  Int(ceil(Double(numberOfDays!)/7.0))
    }


    /*Date
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
    
    /// MARK: Stats calculating subroutines
    
    func compress() {
        //
       // var AllFoods = history + tried
        // whereever I miss a foodname,
    }
    
    func countTriesOrThisFood(foodName: String, photoFilename: String ) -> Int{
        var countOfThisFood = Int()

         if foodName == "" {
             if photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg" {
                 countOfThisFood = foodArray.filter({ $0.filename == photoFilename }).count
             }
             else {
                 countOfThisFood = 1
             }
         }
         else{
             if photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg" {
                 countOfThisFood = foodArray.filter({ $0.filename == photoFilename || $0.name == foodName }).count
             }
             else{
                  countOfThisFood = foodArray.filter({ $0.name == foodName }).count
             }
         }

         if let history = historyArray
         {
             
             if foodName == ""
             {

                if photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
                 {
                     countOfThisFood = countOfThisFood + history.filter({ $0.filename == photoFilename }).count
                 }
             }
             else
             {
                 
                 if photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
                 {
                     countOfThisFood = countOfThisFood + history.filter({ $0.filename == photoFilename || $0.name == foodName }).count
                 }
                 else
                 {
                     countOfThisFood = countOfThisFood + history.filter({ $0.name == foodName }).count
                 }
             }
         }
        return countOfThisFood
    }
    

    /// MARK: Setup
    func loadItems(){
        let request : NSFetchRequest<HistoryTriedFoods> = HistoryTriedFoods.fetchRequest()
        do{
            try historyArray = context.fetch(request)
        }
        catch{
            print("Error fetching data \(error)")
        }
        
        let request2 : NSFetchRequest<TriedFood> = TriedFood.fetchRequest()
        do{
            try foodArray = context.fetch(request2)
        }
        catch{
            print("Error fetching data \(error)")
        }
        
        let request3 : NSFetchRequest<Logons> = Logons.fetchRequest()
              do{
                  try logons = context.fetch(request3)
              }
              catch{
                  print("Error fetching data \(error)")
              }

    }

}
