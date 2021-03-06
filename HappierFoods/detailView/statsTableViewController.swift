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
    var historyArray: [History]?
    var foodArray: [Tried]!
    var logons: [Logons]!
    var list: [Food]!
    var uniqueFoods = [ (String, String)]()
    
   var tryCounts = [ String: Int ]()
    
    var loginRecord = UserDefaults.standard.object(forKey: "loginRecord") as? [ Date ] ?? [ Date ]()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alwaysBounceVertical = false
        loadItems()
        listOfFoodsTried()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)  as! statsTableViewCell
        
         cell.titleOfStatistic.text = ""
         cell.valueOfStatistic.text = ""

        switch indexPath.row{
              case 0:
                  cell.titleOfStatistic.text = "Total Tries"
                  cell.valueOfStatistic.text = String( (historyArray?.count ?? 0) + (foodArray?.count ?? 0) )
              case 1:
                  cell.titleOfStatistic.text = "Total Distinct Foods Tried"
                  cell.valueOfStatistic.text  = String(tryCounts.count)
              case 2:
                  cell.titleOfStatistic.text = "All Log Ins"
                  cell.valueOfStatistic.text = String( loginRecord.count)
              case 3:
                  cell.titleOfStatistic.text = "Average Log Ins per Week"
                  cell.valueOfStatistic.text = String( Double(loginRecord.count)/Double(numberOfWeeks() ))
              case 4:
                  cell.titleOfStatistic.text = "Average Tries per Week"
                  cell.valueOfStatistic.text = String( Double(tryCounts.count)/Double(numberOfWeeks()) )
              case 5:
                    let this = maxTries()
                  cell.imageForStat.image = UIImage(named: photoOfFood(name: this) ?? "1plate.jpeg")
                  cell.titleOfStatistic.text = "Most Retried Food"
                  cell.valueOfStatistic.text = this
              case 6:
                  cell.titleOfStatistic.text = "Number of Foods Tried 5 Times or More"
                  cell.valueOfStatistic.text =  String(tryCounts.filter({$0.value > 5}).count)
              case 7:
                  cell.titleOfStatistic.text = "Number of Foods Tried 12 Times or More"
                  cell.valueOfStatistic.text =  String(tryCounts.filter({$0.value > 12}).count)
             case 8:
                cell.titleOfStatistic.text = "What stat do you want to see... "
                cell.valueOfStatistic.text =  "..here?"
            case 9:
                           cell.titleOfStatistic.text = "Total Targets Set"
                           cell.valueOfStatistic.text = String( list.filter({ $0.type == entryType.target.rawValue || $0.type == entryType.targetCompleted.rawValue}).count )
            case 10:
                             cell.titleOfStatistic.text = "Total Targets Done"
                             cell.valueOfStatistic.text = String( list.filter({ $0.type == entryType.targetCompleted.rawValue}).count )
                         case 11:
                              cell.titleOfStatistic.text = "Total Targets Open"
                              cell.valueOfStatistic.text = String( list.filter({ $0.type == entryType.target.rawValue }).count )
                         case 12:
                              cell.titleOfStatistic.text = "Challenges Done"
                              cell.valueOfStatistic.text = String( list.filter({ $0.type == entryType.challenge.rawValue}).count )
                         case 13:
                             cell.titleOfStatistic.text = "Average Targets Set per Week"
                             cell.valueOfStatistic.text = String( Double(list.filter({ $0.type == entryType.target.rawValue || $0.type == entryType.targetCompleted.rawValue}).count )/Double(numberOfWeeks() ))
                         case 14:
                            cell.titleOfStatistic.text = "Average Targets Met per Week"
                            cell.valueOfStatistic.text = String( Double(list.filter({ $0.type == entryType.targetCompleted.rawValue}).count )/Double(numberOfWeeks() ))
//                         case 15:
////                               let this = maxTries()
////                             cell.imageForStat.image = UIImage(named: photoOfFood(name: this) ?? "1plate.jpeg")
////                             cell.titleOfStatistic.text = "Most Retried Food"
////                             cell.valueOfStatistic.text = this
//                         case 16:
////                             cell.titleOfStatistic.text = "Number of foods tried 5 times of more"
////                             cell.valueOfStatistic.text =  String(tryCounts.filter({$0.value > 5}).count)
//                         case 17:
////                             cell.titleOfStatistic.text = "Number of foods tried 12 times of more"
////                             cell.valueOfStatistic.text =  String(tryCounts.filter({$0.value > 12}).count)
//            
              default:
                  cell.titleOfStatistic.text = " "
          }
          
    if indexPath.row.isMultiple(of: 2) == true{
                              cell.backgroundColor =  #colorLiteral(red: 0.9921568627, green: 0.3215686275, blue: 0.4666666667, alpha: 1)
                      }
                      else{
                              cell.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.5285187325, blue: 0.7176470588, alpha: 1)
                      }
          
             

        return cell
    }
    
    func maxTries() -> String
    {
        let maximum = tryCounts.values.max()
        var maxTriedFoods = [String]()
        
        for tries in tryCounts{
            if tries.value == maximum
            {
                maxTriedFoods.append(tries.key)
            }
        }
        
        return maxTriedFoods.randomElement() ?? "No tries yet"
        
    }
    
    func photoOfFood(name: String) -> String? {
        let this = list.filter({$0.name == name}).filter({$0.filename?.dropLast(10) == "plate.jpeg" })
        return this.randomElement()?.filename ?? nil
    }
    
    func listOfFoodsTried(){
        
        var foodNames = Array(Set(foodArray.compactMap({$0.name})))
        foodNames = foodNames.filter({$0 != ""})
        print(foodNames)
        
        /// check for random spaces
      
        
        for uniqueFood in foodNames{
            let count = foodArray.filter({$0.name == uniqueFood })
            tryCounts[uniqueFood] = count.count
        }
        
        print(tryCounts)
        
        var orphans  = foodArray.filter({ $0.name == ""})
        orphans = orphans.filter({["1plate.jpeg", "2plate.jpeg", "3plate.jpeg", "4plate.jpeg", "5plate.jpeg"].contains($0.filename!.components(separatedBy: "/").last) == false })
        if orphans.count > 0
        {
            for x in (0 ... orphans.count - 1).reversed() {
                var relations = foodArray.filter{$0.filename == orphans[x].filename}
                relations = relations.filter({$0.name != ""})
                let candidateNames = relations.compactMap({$0.name})
            
                print(candidateNames)
            
                if candidateNames.count > 0{
                    tryCounts[candidateNames.first!] = tryCounts[candidateNames.first!]! + 1
                    orphans.remove(at: x)
                }
    
            }
        }
        
        let remainingOrphanFilenames = Array(Set(orphans.compactMap({$0.filename})))
        var placeholder = "."
        
        for remainingOrphans in remainingOrphanFilenames{
            tryCounts[placeholder] = orphans.filter({$0.filename == remainingOrphans}).count
            placeholder = placeholder +  "."
        }
        // What makes a distinct food
        /// matching written name
        
        /// list of unique names
        
        /// matching photo
        
        /// excluding placeholders
        
        /// step 1
        
       //
        //var unallocatedFoods =
        
//        var countOfThisFood = Int()
//
//              if foodName == "" {
//                  if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg" {
//                      countOfThisFood = foodArray.filter({ $0.filename == detailToDisplay.photoFilename }).count
//                  }
//                  else {
//                      countOfThisFood = 1
//                  }
//              }
//              else{
//                  if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg" {
//                      countOfThisFood = foodArray.filter({ $0.filename == detailToDisplay.photoFilename || $0.name == detailToDisplay.foodName }).count
//                  }
//                  else{
//                       countOfThisFood = foodArray.filter({ $0.name == detailToDisplay.foodName }).count
//                  }
//              }
//
//              if let history = historyArray
//              {
//
//                  if foodName == ""
//                  {
//
//                      if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
//                      {
//                          countOfThisFood = countOfThisFood + history.filter({ $0.filename == detailToDisplay.photoFilename }).count
//                      }
//                  }
//                  else
//                  {
//
//                      if detailToDisplay.photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
//                      {
//                          countOfThisFood = countOfThisFood + history.filter({ $0.filename == detailToDisplay.photoFilename || $0.name == detailToDisplay.foodName }).count
//                      }
//                      else
//                      {
//                          countOfThisFood = countOfThisFood + history.filter({ $0.name == detailToDisplay.foodName }).count
//                      }
//                  }
//              }

        
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
        if numberOfDays == 0 || numberOfDays == nil {numberOfDays = 1}
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
        let request : NSFetchRequest<History> = History.fetchRequest()
        do{
            try historyArray = context.fetch(request)
        }
        catch{
            print("Error fetching data \(error)")
        }
        
        let request2 : NSFetchRequest<Tried> = Tried.fetchRequest()
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
        
        let request4 : NSFetchRequest<Food> = Food.fetchRequest()
                     do{
                         try list = context.fetch(request4)
                     }
                     catch{
                         print("Error fetching data \(error)")
                     }

    }

}
