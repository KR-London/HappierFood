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

    //
    //  ViewController.swift
    //  ARFaceTrackingSmileDetection

    
    @IBOutlet weak var warningLabel: UILabel!
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var faceView: FaceView!
    
    @IBAction func freezeButton(_ sender: Any){
        shouldUpdateEmoji.toggle()
        warningLabel.alpha = 0
    }
    var arSession = ARSession()
    
    var shouldUpdateEmoji: Bool = true
    
    @IBAction func sliderSliding(_ sender: Any) {
         updateUI(value: -1 + 2*slider!.value)
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            warningLabel.alpha = 0
            
        }
    
    override func viewDidAppear(_ animated: Bool) {
        if usingSimulator == false{
            // Create a session configuration
            let configuration = ARFaceTrackingConfiguration()
            
            var videoFormat = ARFaceTrackingConfiguration.supportedVideoFormats[0]
            for format in ARFaceTrackingConfiguration.supportedVideoFormats {
                if format.framesPerSecond < videoFormat.framesPerSecond {
                    videoFormat = format
                }
            }
            configuration.videoFormat = videoFormat
            // Set the session's delegate
            arSession.delegate = self
            
            // Run the session with the face tracking configuration
            arSession.run(configuration)
        }
    }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            // Pause the view's session
            arSession.pause()
        }
        
        // MARK: - ARSessionDelegate
        
        // Called every time the ARSession updates an anchor(s)
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            for anchor in anchors {
                if shouldUpdateEmoji == true {
                    
                    if warningLabel.alpha != 0 {
                        DispatchQueue.main.async {
                            let animator = UIViewPropertyAnimator(duration: 0.25, curve: .easeOut) {
                                self.warningLabel.alpha = 0
                            }
                            animator.startAnimation()
                        }
                    }
                    
                    if let faceAnchor = anchor as? ARFaceAnchor {
                        for blendShape in faceAnchor.blendShapes {
                            //if blendShape.key == .{}
                            if blendShape.key == .mouthSmileLeft {
                                print("Smile Left: \(blendShape.value)")
                                faceView.mouthCurvature = 2*Double(truncating: blendShape.value) - 1
                            } else if blendShape.key == .mouthSmileRight {
                                print("Smile Right: \(blendShape.value)")
                            }
                        }
                    }
                }
            }
        }
    
    // Called every single frame
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        for anchor in frame.anchors {
            if let faceAnchor = anchor as? ARFaceAnchor {
                if faceAnchor.isTracked == false && shouldUpdateEmoji == true {
                    if warningLabel.alpha == 0 {
                        DispatchQueue.main.async {
                            let animator = UIViewPropertyAnimator(duration: 4, curve: .easeIn) {
                                self.warningLabel.alpha = 1
                            }
                            animator.startAnimation()
                        }
                    }
                    print("lost the face")
                }
            }
        }
    }
    
    private func updateUI(value: Float){
        
        /// do i need a bit of safety code here - if I get a crazy input? Or is this handled as standard.
        faceView.mouthCurvature = Double(value)
    }
}
