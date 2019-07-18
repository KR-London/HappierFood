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
    
   // @IBOutlet var collectionView: UICollectionView!
    // @IBOutlet var collectionView: UICollectionView!
    
    //collectionView.dataSource = self
   // collectionView.delegate = self
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
        if let temp = historyArray?.flatMap({$0.saveNumber})
        {
            let sections = temp.max()!
            maximumSaveNumber = Int(sections)
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
         if maximumSaveNumber > 0
         {
            return maximumSaveNumber + 1
        }
         else{
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       // let thisData = historyArray?.filter({$0.saveNumber == maximumSaveNumber - section}).count
        
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
        //cell.backgroundColor = UIColor.green
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
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader ){
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WeekHeaderView", for: indexPath) as! WeekHeaderView
            headerView.backgroundColor = UIColor.blue
            headerView.weekLabel.text = "Save \(maximumSaveNumber - indexPath.section + 1)"
            return headerView
        }
        fatalError()
    }
}

// MARK: History View extension
//
//extension HistoryCollectionViewController: UICollectionViewDelegateFlowLayout {
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
////    func collectionView(_ collectionView: UICollectionView,
////                        layout collectionViewLayout: UICollectionViewLayout,
////                        insetForSectionAt section: Int) -> UIEdgeInsets {
////        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
////    }
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
//}
