//
//  detailContainer3ViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 14/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class detailContainer3ViewController: UIViewController {

    
    @IBOutlet weak var ratingOrInspo: UILabel!
    
    @IBOutlet weak var topFace: UIImageView!
    @IBOutlet weak var emojiFace: UIView!
    
    @IBOutlet weak var smileView: smileView!
    var detailToDisplay = (photoFilename: "", foodName: "not initialosed. ", rating: 0.0, triedOn: NSDate.init(), notes: "" )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingOrInspo.text = "Date tried goes here"

        emojiFace.backgroundColor = UIColor(patternImage: UIImage(named:"face.png")!)
        // Do any additional setup after loading the view.
        switch Double(detailToDisplay.rating)
        {
        case 0.1...0.5 :
            topFace.image = UIImage(named: "eyeLookInLeft_browOuterUpLeft.png")
        case 0.5...:
            topFace.image = UIImage(named: "eyeLookDownLeft_browOuterUpLeft.png")
        case -0.5 ... -0.1:
            topFace.image = UIImage(named: "eyeWideLeft_browDownLeft.png")
        case -1 ... -0.5:
            topFace.image = UIImage(named: "eyesShut_browDownLeft.png")
        default:
            topFace.image =  UIImage(named: "eyeOpen_browDownLeft.png")
        }
        
        smileView.mouthCurvature = detailToDisplay.rating
        
        
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
