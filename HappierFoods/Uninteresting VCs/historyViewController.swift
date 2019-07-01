//
//  historyViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 06/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import CoreData

class historyViewController: UIViewController {

    @IBOutlet weak var resetToNewWeek: UIButton!
    
    @IBOutlet weak var clearAllData: UIButton!
    
    @IBAction func cacheWeek(_ sender: UIButton) {
        weak var main = navigationController?.viewControllers[0] as! mainViewController
        main?.cacheData()
    }
    
    
    @IBAction func clearData(_ sender: Any) {
        
        weak var main = navigationController?.viewControllers[0] as! mainViewController
        main?.deleteAllData("TargetFood")
        main?.deleteAllData("TriedFood")
        main?.mainCollectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    
    deinit{
        print("OS reclaiming memory from history view")
    }
}
