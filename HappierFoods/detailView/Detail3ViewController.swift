//
//  ChristyViewController.swift
//  SegueThroughCellButton
//
//  Created by Kate Roberts on 05/06/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class Detail3ViewController: UIViewController {
    
      var detailToDisplay = (photoFilename: "tick.jpg", foodName: "not initialised", rating: 0.0, triedOn: Date(), notes: "" )
 //   @IBOutlet var detail1Label: UILabel?

    @IBOutlet weak var topFaceView: UIImageView!
    @IBOutlet weak var faceView: smileView!
    @IBOutlet weak var faceRating: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    faceView.mouthCurvature = detailToDisplay.rating
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
