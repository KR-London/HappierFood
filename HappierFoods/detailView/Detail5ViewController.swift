//
//  ChristyViewController.swift
//  SegueThroughCellButton
//
//  Created by Kate Roberts on 05/06/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class Detail5ViewController: UIViewController {
    
    var buttonPress: ((_ value: String) -> Void)?

    var detailToDisplay = (photoFilename: "tick.jpg", foodName: "not initialised", rating: 0.0, triedOn: Date(), notes: "" )
    
    @IBOutlet weak var tryButton: UIButton!

    @IBAction func tryButtonPressed(_ sender: UIButton) {
        
        if let feedback = buttonPress{
            feedback("Try")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "detailToRate"{
//            let dvc = segue.destination as! rateFoodViewController
//            dvc.imagePlaceholder = UIImage(named: detailToDisplay.photoFilename) ?? UIImage(named: "databasePlaceholderImage.001.jpg")!
//            ///   newViewController.rating = 0.0
//            dvc.foodName = detailToDisplay.foodName
//            dvc.dateTargetSet = detailToDisplay.triedOn
//        }
//    }
    
    func buttonPress(handler: @escaping (_ value: String) -> Void) {
        
        buttonPress = handler
    }
    
    deinit{
        print("OS reclaiming memory from detail 5 view")
    }
 
}
