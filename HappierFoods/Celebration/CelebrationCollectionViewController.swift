//
//  CelebrationCollectionViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 26/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import Foundation
import Darwin
import CoreData

private let reuseIdentifier = "Cell"

class CelebrationCollectionViewController: UICollectionViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var food: [NSManagedObject] = []
    var foodArray: [TriedFood]!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()

    }


    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> mainCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! mainCollectionViewCell
        
        // I'm not handling the errors here
        if indexPath.row < 9{
                let fileToLoad = foodArray[indexPath.row].filename ?? "chaos.jpg"
                cell.displayContent(image: fileToLoad)
                cell.tickImage.isHidden = false
        }
        return cell
    }
    
    /// MARK: Setup
    func loadItems(){
        let request : NSFetchRequest<TriedFood> = TriedFood.fetchRequest()
        do{
            try foodArray = context.fetch(request)
        }
        catch{
            print("Error fetching data \(error)")
        }
    }
}

// MARK: Collection View extension

extension HistoryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width/3 - 16, height: collectionView.bounds.size.width/3 - 16)
}
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
}
