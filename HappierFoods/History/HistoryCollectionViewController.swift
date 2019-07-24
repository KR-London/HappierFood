//
//  CelebrationCollectionViewController.swift
//  HappierFoods
////  Created by Kate Roberts on 26/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import Foundation
import Darwin
import CoreData

private let reuseIdentifier = "HistoryCell"

class HistoryCollectionViewController: UICollectionViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var history: [NSManagedObject] = []
    var historyArray: [HistoryTriedFoods]?
    var maximumSaveNumber = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
        if let temp = historyArray?.flatMap({$0.saveNumber})
        {
            print(temp)
            let sections = temp.max() ?? 0
            maximumSaveNumber = Int(sections)
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return maximumSaveNumber
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyArray?.filter({$0.saveNumber == maximumSaveNumber - section}).count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> HistoryCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HistoryCollectionViewCell
        
        if let thisData = historyArray?.filter({$0.saveNumber == maximumSaveNumber - indexPath.section})
        {
            ///I'm not handling the errors here
            if indexPath.row < thisData.count {
                let fileToLoadRow = thisData[indexPath.row]
                let fileToLoad = fileToLoadRow.filename ?? "chaos.jpg"
                cell.displayContent(image: fileToLoad)
            }
        }
        return cell
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
        
        /// clean data
        if let history = historyArray{
            if historyArray!.count > 0  {
                let historyArrayCount = historyArray!.count
                for i in 0 ... (historyArray!.count - 1){
                    if UIImage(named: historyArray![historyArrayCount - 1  - i].filename ?? "neverUsed") == nil
                {
                    context.delete(historyArray![historyArrayCount - 1 - i])
                    do{
                        try context.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                    //historyArray.remove(at: historyArrayCount - 1 - i)
                }
            }
        }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader ){
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WeekHeaderView", for: indexPath) as! WeekHeaderView
            headerView.backgroundColor = UIColor().HexToColor(hexString: "#93b5C6", alpha: 1.0)
            headerView.tintColor = UIColor().HexToColor(hexString: "#DDEDAA", alpha: 1.0)
            headerView.weekLabel.text = "Save \(maximumSaveNumber - indexPath.section)"
            
            return headerView
        }
        fatalError()
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.init(top: 40, left: 0, bottom: 10, right: 0)
//    }
    
    //3
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//
//
//        return UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
//    }
    
}

// MARK: History View extension

extension HistoryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
        }
////
////    func collectionView(_ collectionView: UICollectionView,
////                        layout collectionViewLayout: UICollectionViewLayout,
////                        sizeForItemAt indexPath: IndexPath) -> CGSize {
////
////        return CGSize(width: collectionView.bounds.size.width/3 - 16, height: collectionView.bounds.size.width/3 - 16)
////    }
////
////    func collectionView(_ collectionView: UICollectionView,
////                        layout collectionViewLayout: UICollectionViewLayout,
////                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
////        return 8
////    }
////
////    func collectionView(_ collectionView: UICollectionView,
////                        layout collectionViewLayout: UICollectionViewLayout,
////                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
////        return 8
////    }
////


//let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//layout.sectionInset = UIEdgeInsets(top: 10.0, left: 1.0, bottom: 1.0, right: 1.0)
////}
////
////extension HistoryCollectionViewController: UICollectionViewDataSource{
//
////    override func collectionView(_ collectionView: UICollectionView,
////                                 viewForSupplementaryElementOfKind kind: String,
////                                 at indexPath: IndexPath) -> WeekHeaderView {
////        // 1
////        switch kind {
////        // 2
////        case UICollectionView.elementKindSectionHeader:
////            // 3
////            guard
////                let headerView = collectionView.dequeueReusableSupplementaryView(
////                    ofKind: kind,
////                    withReuseIdentifier: "\(WeekHeaderView.self)",
////                    for: indexPath) as? WeekHeaderView
////                else {
////                    fatalError("Invalid view type")
////            }
////
////         //   let searchTerm = searches[indexPath.section].searchTerm
////          //  headerView.label.text = searchTerm
////            return headerView
////        default:
////            // 4
////            assert(false, "Invalid element type")
////        }
////    }
//
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//         if (kind == UICollectionView.elementKindSectionHeader ){
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WeekHeaderView", for: indexPath)
//            self.backgroundColor = UIColor.blue
//            return headerView
//        }
//        fatalError()
//    }
//
}
