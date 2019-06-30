//
//  ChristyViewController.swift
//  SegueThroughCellButton
//
//  Created by Kate Roberts on 05/06/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class Detail2ViewController: UIViewController {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodName.font = UIFont(name: "07891284.ttf", size: 42)
        if foodName.text!.count < 1 {
            foodName.text = "No food name stored"
        }
    }
}
