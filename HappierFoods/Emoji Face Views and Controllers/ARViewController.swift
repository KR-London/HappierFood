//
//  ARViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 09/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import ARKit

let usingSimulator = false

class ARViewController: UIViewController, ARSessionDelegate {
    
    @IBOutlet weak var warningLabel: UILabel!
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var faceView: FaceView!
    
    @IBAction func freezeButton(_ sender: Any){
        shouldUpdateEmoji.toggle()
        warningLabel.alpha = 0
    }
    var shouldUpdateEmoji: Bool = true
    
    @IBAction func sliderSliding(_ sender: Any) {
         updateUI(value: -1 + 2*slider!.value)
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            warningLabel.alpha = 0
            
        }
    
    override func viewDidAppear(_ animated: Bool) {
    }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        }
    
    private func updateUI(value: Float){
        
        /// do i need a bit of safety code here - if I get a crazy input? Or is this handled as standard.
        faceView.mouthCurvature = Double(value)
    }
}
