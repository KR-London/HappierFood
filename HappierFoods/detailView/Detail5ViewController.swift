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
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(detailToDisplay)
    }

}
