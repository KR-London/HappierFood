//
//  FaceViewController2.swift
//  HappierFoods
//
//  Created by Kate Roberts on 09/04/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//
import UIKit
import SceneKit
import ARKit

class FaceViewController2: UIViewController, ARSessionDelegate {

        
        @IBOutlet weak var slider: UISlider!
        @IBOutlet var sceneView: ARSCNView!
        @IBOutlet weak var faceView: FaceView!
        
        var arSession = ARSession()
        
        @IBAction func sliderSliding(_ sender: Any) {
            updateUI(value: -1 + 2*slider!.value)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set the session's delegate
            arSession.delegate = self
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // Create a session configuration
            let configuration = ARFaceTrackingConfiguration()
            
            // Run the session with the face tracking configuration
            arSession.run(configuration)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            // Pause the view's session
            sceneView.session.pause()
        }
        
        // MARK: - ARSessionDelegate
        
        // Called every time the ARSession updates an anchor(s)
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            for anchor in anchors {
                if let faceAnchor = anchor as? ARFaceAnchor {
                    for blendShape in faceAnchor.blendShapes {
                        //if blendShape.key == .{}
                        if blendShape.key == .mouthSmileLeft {
                            print("Smile Left: \(blendShape.value)")
                            faceView.mouthCurvature = 2*Double(blendShape.value) - 1
                        } else if blendShape.key == .mouthSmileRight {
                            print("Smile Right: \(blendShape.value)")
                        }
                    }
                }
            }
        }
        
        private func updateUI(value: Float){
            
            /// do i need a bit of safety code here - if I get a crazy input? Or is this handled as standard.
            faceView.mouthCurvature = Double(value)
            //[FacialExpression.Mouth.Frown:-1.0,.Grin:0.5,.Smile:1.0,.Smirk:-0.5,.Neutral:0.0 ]
        }
}

