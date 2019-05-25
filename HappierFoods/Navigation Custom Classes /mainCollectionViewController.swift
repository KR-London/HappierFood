//
//  mainCollectionViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 06/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

// notes on calculations:
// The grid need screen width size out of the height
// remaining space = height - width - tab bar
// or safearea.height - width

import UIKit

private let reuseIdentifier = "mainViewCell"

class mainCollectionViewController: UICollectionViewController {

private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        collectionView.register(mainCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 9
    }

//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//
//        // Configure the cell
//
//        return cell
//    }
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        //1
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! mainCollectionViewCell
        //2
        //let flickrPhoto = photo(for: indexPath)
        cell.backgroundColor = .blue
        //3
        //cell.imageView.image = flickrPhoto.thumbnail
        
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView,
//                                 viewForSupplementaryElementOfKind kind: String,
//                                 at indexPath: IndexPath) -> UICollectionReusableView {
////        // 1
//        switch kind {
//        // 2
//        case UICollectionView.elementKindSectionHeader:
//            // 3
//            guard
//                let headerView = collectionView.dequeueReusableSupplementaryView(
//                    ofKind: kind,
//                    withReuseIdentifier: "headerReuseIdentifier",
//                    for: indexPath) as? headerCollectionReusableView
//                else {
//                    fatalError("Invalid view type")
//            }
//            return headerView
//        case UICollectionView.elementKindSectionFooter:
//            // 3
//            guard
//                let headerView = collectionView.dequeueReusableSupplementaryView(
//                    ofKind: kind,
//                    withReuseIdentifier: "footerReuseIdentifier",
//                    for: indexPath) as? headerCollectionReusableView
//                else {
//                    fatalError("Invalid view type")
//            }
//            return headerView
//        default:
//            // 4
//            assert(false, "Invalid element type")
//        }
 //   }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
// MARK: - Collection View Flow Layout Delegate
//extension FlickrPhotosViewController : UICollectionViewDelegateFlowLayout {
//    //1
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //2
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow
//        
//        return CGSize(width: widthPerItem, height: widthPerItem)
//    }
//    
//    //3
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
//    
//    // 4
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.left
//    }
//}


extension mainCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width/3 - 16, height: 120)
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
        return UIEdgeInsets.init(top: 60, left: 8, bottom: 8, right: 8)
    }
}
