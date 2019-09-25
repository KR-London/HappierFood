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
                let filepath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(fileToLoad)
                cell.displayContent(image: filepath)
                cell.tickImage.isHidden = false
        }
        
        switch indexPath.row
        {
            case 0:
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                    cell.tickImage.isHidden = true
                    cell.cellImage.isHidden = true
                    cell.backgroundColor = UIColor(red: 239/256, green: 71/256, blue: 111/256, alpha: 1)
                    cell.cellLabel.isHidden = false
                    cell.cellLabel.text = "Well"
                    cell.cellLabel.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 20 )
                    
                }
                    
            case 1:
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
                    cell.tickImage.isHidden = true
                    cell.cellImage.isHidden = true
                    cell.backgroundColor = UIColor(red: 255/256, green: 209/256, blue: 102/256, alpha: 1)
                    cell.cellLabel.isHidden = false
                    cell.cellLabel.text = "done"
                    cell.cellLabel.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 20 )
                }
            
            case 2:
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){
                    cell.tickImage.isHidden = true
                    cell.cellImage.isHidden = true
                    cell.backgroundColor = UIColor(red: 6/256, green: 214/256, blue: 160/256, alpha: 1)
                    cell.cellLabel.isHidden = false
                    cell.cellLabel.text = "!!!"
                    cell.cellLabel.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 20 )
            }
            
            case 3:
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)){
                cell.tickImage.isHidden = true
                cell.cellImage.isHidden = true
                cell.backgroundColor = UIColor(red: 6/256, green: 214/256, blue: 160/256, alpha: 1)
                cell.cellLabel.isHidden = false
                cell.cellLabel.text = "You"
                cell.cellLabel.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 20 )
            }
            
            case 4:
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)){
                    cell.tickImage.isHidden = true
                    cell.cellImage.isHidden = true
                    cell.backgroundColor = UIColor(red: 239/256, green: 71/256, blue: 111/256, alpha: 1)
                    cell.cellLabel.isHidden = false
                    cell.cellLabel.text = "did"
                    cell.cellLabel.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 20 )
            }
            
            case 5:
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6)){
                    cell.tickImage.isHidden = true
                    cell.cellImage.isHidden = true
                    cell.backgroundColor = UIColor(red: 255/256, green: 209/256, blue: 102/256, alpha: 1)
                    cell.cellLabel.isHidden = false
                    cell.cellLabel.text = "it!"
                    cell.cellLabel.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 20 )
            }
            
            case 6:
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7)){
                    cell.tickImage.isHidden = true
                    cell.cellImage.isHidden = true
                    cell.backgroundColor = UIColor(red: 255/256, green: 209/256, blue: 102/256, alpha: 1)
                    cell.cellLabel.isHidden = false
                    cell.cellLabel.text = "9"
                    cell.cellLabel.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 20 )
                }
            
            case 7:
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8)){
                    cell.tickImage.isHidden = true
                    cell.cellImage.isHidden = true
                    cell.backgroundColor = UIColor(red: 6/256, green: 214/256, blue: 160/256, alpha: 1)
                    
                    cell.cellLabel.isHidden = false
                    cell.cellLabel.text = "foods"
                    cell.cellLabel.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 20 )
            }
          
            case 8:
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(9)){
                    cell.tickImage.isHidden = true
                    cell.cellImage.isHidden = true
                    cell.backgroundColor = UIColor(red: 239/256, green: 71/256, blue: 111/256, alpha: 1)
                    cell.cellLabel.isHidden = false
                    cell.cellLabel.text = "tried!"
                    cell.cellLabel.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 20 )
            }
            
            default: break
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

extension CelebrationCollectionViewController: UICollectionViewDelegateFlowLayout {
    
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
