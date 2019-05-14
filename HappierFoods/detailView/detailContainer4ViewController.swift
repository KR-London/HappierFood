//
//  detailContainer4ViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 14/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class detailContainer4ViewController: UIViewController {

    
    @IBOutlet weak var motivationText: UITextView!
    
    var detailToDisplay = (photoFilename: "", foodName: "not initialosed. ", rating: 0.0, triedOn: NSDate.init(), notes: "" )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motivationText.text = detailToDisplay.notes
        // Do any additional setup after loading the view.
    }
    

}
