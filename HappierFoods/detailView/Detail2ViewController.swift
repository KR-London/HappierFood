//
//  ChristyViewController.swift
//  SegueThroughCellButton
//
//  Created by Kate Roberts on 05/06/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class Detail2ViewController: UIViewController {
    
 //   @IBOutlet var detail1Label: UILabel?
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodName.font = UIFont(name: "07891284.ttf", size: 42)
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
