////
////  statsCollectionViewController.swift
////  HappierFoods
////
////  Created by Kate Roberts on 29/10/2019.
////  Copyright © 2019 Kate Roberts. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//private let reuseIdentifier = "statsCell"
//
//class statsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var historyArray: [HistoryTriedFoods]?
//    var foodArray: [TriedFood]!
//    
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadItems()
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.bounds.size.width - 8 , height: collectionView.bounds.size.width/9 - 8 )
//    }
//
////    func collectionView(_ collectionView: UICollectionView,
////                        layout collectionViewLayout: UICollectionViewLayout,
////                        insetForSectionAt section: Int) -> UIEdgeInsets {
////        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
////    }
//////
//
//    // MARK: UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return 9
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//           as! statsCollectionViewCell
//        {
//        switch indexPath.row{
//            case 0:
//                cell.titleOfStatistic.text = "Total Tries"
//                cell.valueOfStatistic.text = String( (historyArray?.count ?? 0) + (foodArray?.count ?? 0) )
//            case 1:
//                cell.titleOfStatistic.text = "Total Foods Tried"
//            case 2:
//                cell.titleOfStatistic.text = "Total Logons"
//            case 3:
//                cell.titleOfStatistic.text = "Average Logon per week"
//            case 4:
//                cell.titleOfStatistic.text = "Average Tries Per Week"
//            case 5:
//                cell.titleOfStatistic.text = "Most Retried Food"
//            case 6:
//                cell.titleOfStatistic.text = "Count Pond Fish (< 5 Tries)"
//            case 7:
//                cell.titleOfStatistic.text = "Count Lake Fish (< 12 Tries)"
//            case 8:
//                cell.titleOfStatistic.text = "Count Sea Fish (> 12 Tries)"
//            default:
//                cell.titleOfStatistic.text = " "
//        }
//        
//        cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        return cell
//    }
//    
//    /// MARK: Stats calculating subroutines
//    
//    func countTriesOrThisFood(foodName: String, photoFilename: String ) -> Int{
//        var countOfThisFood = Int()
//
//         if foodName == "" {
//             if photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg" {
//                 countOfThisFood = foodArray.filter({ $0.filename == photoFilename }).count
//             }
//             else {
//                 countOfThisFood = 1
//             }
//         }
//         else{
//             if photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg" {
//                 countOfThisFood = foodArray.filter({ $0.filename == photoFilename || $0.name == foodName }).count
//             }
//             else{
//                  countOfThisFood = foodArray.filter({ $0.name == foodName }).count
//             }
//         }
//
//         if let history = historyArray
//         {
//             
//             if foodName == ""
//             {
//                 
//                 if photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
//                 {
//                     countOfThisFood = countOfThisFood + history.filter({ $0.filename == photoFilename }).count
//                 }
//             }
//             else
//             {
//                 
//                 if photoFilename.components(separatedBy: "/").last != "databasePlaceholderImage.001.jpeg"
//                 {
//                     countOfThisFood = countOfThisFood + history.filter({ $0.filename == photoFilename || $0.name == foodName }).count
//                 }
//                 else
//                 {
//                     countOfThisFood = countOfThisFood + history.filter({ $0.name == foodName }).count
//                 }
//             }
//         }
//        return countOfThisFood
//    }
//    
//
//    /// MARK: Setup
//    func loadItems(){
//        let request : NSFetchRequest<HistoryTriedFoods> = HistoryTriedFoods.fetchRequest()
//        do{
//            try historyArray = context.fetch(request)
//        }
//        catch{
//            print("Error fetching data \(error)")
//        }
//        
//        let request2 : NSFetchRequest<TriedFood> = TriedFood.fetchRequest()
//        do{
//            try foodArray = context.fetch(request2)
//        }
//        catch{
//            print("Error fetching data \(error)")
//        }
//
//    }
//}
