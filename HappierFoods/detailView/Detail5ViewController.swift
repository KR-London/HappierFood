//
//  ChristyViewController.swift
//  SegueThroughCellButton
//
//  Created by Kate Roberts on 05/06/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class Detail5ViewController: UIViewController {

    var detailToDisplay = (photoFilename: "tick.jpg", foodName: "not initialised", rating: 0.0, triedOn: Date(), notes: "" )
    //var whereAmI = (String(), Costume())
    
    @IBOutlet weak var tryButton: UIButton!

    @IBAction func tryButtonPressed(_ sender: Any) {
        ///load rate food view controller
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "rateFoodVC") as! rateFoodViewController
        newViewController.imagePlaceholder = UIImage(named: detailToDisplay.photoFilename) ?? UIImage(named: "databasePlaceholderImage.001.jpg")!
     ///   newViewController.rating = 0.0
        newViewController.foodName = detailToDisplay.foodName
        newViewController.dateTargetSet = detailToDisplay.triedOn
        newViewController.presentState = .ConvertTargetToTry
        self.present(newViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(detailToDisplay)
    }

}
