
import UIKit
import ARKit

enum eye : String {
    case shut
    case lookingLeft
    case lookingRight
    case lookingUp
    case lookingDown
    case lookingWide
    case lookingStraight
}

enum brow : String {
    case up
    case down
}

//lazy var BottomFaceView: UIImageView = {
//    let contentView = UIImageView()
//    
//    contentView.image = UIImage(named: "face.png")
//    //contentView.image = UIImage(named: "chaos.jpg")
//    contentView.translatesAutoresizingMaskIntoConstraints = false
//    return contentView
//}()

//let usingSimulator = false

class customFaceARViewController: UIViewController, ARSessionDelegate {
    
    //
    //  ViewController.swift
    //  ARFaceTrackingSmileDetection
    

    @IBOutlet weak var smileView: smileView!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var faceView: handDrawnFaceView!
    
    @IBAction func freezeButton(_ sender: Any){
        shouldUpdateEmoji.toggle()
    }
    var arSession = ARSession()
    
    var shouldUpdateEmoji: Bool = true
    
    @IBAction func sliderSliding(_ sender: Any) {
        updateUI(value: -1 + 2*slider!.value)
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name(rawValue: "printValue"), object: nil, userInfo: ["value" : "Pass Me this string"])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        warningLabel.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if usingSimulator == false{
//            // Create a session configuration
//            let configuration = ARFaceTrackingConfiguration()
//
//            var videoFormat = ARFaceTrackingConfiguration.supportedVideoFormats[0]
//            for format in ARFaceTrackingConfiguration.supportedVideoFormats {
//                if format.framesPerSecond < videoFormat.framesPerSecond {
//                    videoFormat = format
//                }
//            }
//            configuration.videoFormat = videoFormat
//            // Set the session's delegate
//            arSession.delegate = self
//
//            // Run the session with the face tracking configuration
//            arSession.run(configuration)
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
       // arSession.pause()
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
//                    for blendShape in faceAnchor.blendShapes {
//                        //if blendShape.key == .{}
//                        if blendShape.key == .mouthSmileLeft {
//                            print("Smile Left: \(blendShape.value)")
//                            faceView.mouthCurvature = 2*Double(blendShape.value) - 1
//                        } else if blendShape.key == .mouthSmileRight {
//                            print("Smile Right: \(blendShape.value)")
//                        }
//                    }
                    
                    showEmotion(userFace: faceAnchor)
                }
            }
        }
    }
    
    // Called every single frame
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        for anchor in frame.anchors {
            if let faceAnchor = anchor as? ARFaceAnchor {
                if faceAnchor.isTracked == false {
                    if warningLabel.alpha == 0 && shouldUpdateEmoji == true {
                        DispatchQueue.main.async {
                            let animator = UIViewPropertyAnimator(duration: 4, curve: .easeIn) {
                                self.warningLabel.alpha = 1
                            }
                            animator.startAnimation()
                        }
                    }
                  //  print("lost the face")
                }
            }
        }
    }
    
    private func updateUI(value: Float){
        
        /// do i need a bit of safety code here - if I get a crazy input? Or is this handled as standard.
        smileView.mouthCurvature = Double(value)
        //[FacialExpression.Mouth.Frown:-1.0,.Grin:0.5,.Smile:1.0,.Smirk:-0.5,.Neutral:0.0 ]
    }
    
    func showEmotion(userFace: ARFaceAnchor){
        for blendShape in userFace.blendShapes {
            //if blendShape.key == .{}
            if blendShape.key == .mouthSmileLeft {
                smileView.mouthCurvature = 2*Double(truncating: blendShape.value) - 1
            } else if blendShape.key == .mouthSmileRight {
            }
            if blendShape.key == .browOuterUpLeft{
                if Double(truncating: blendShape.value) > 0.5
                {faceView.topFace.image = UIImage(named:  "eyeLookDownLeft_browOuterUpLeft.png")}
                else
                {
                    faceView.topFace.image = UIImage(named:  "eyeOpen_browDownLeft.png")}
                }
            }
            
//            if blendShape.key == .browDownLeft {
//                faceView.topFace.image = UIImage(named:  "eyeLookDownLeft_browDownLeft.png")
//            }
//            if blendShape.key == .eye {
//                faceView.topFace.image = UIImage(named:  "eyeLookDownLeft_browDownLeft.png")
//            }
        }
        
        
//        var leftEye = eye.lookingStraight
//        var rightEye = eye.lookingStraight
//        var browLine = brow.down
//
//        for blendShape in userFace.blendShapes {
//        switch blendShape.key
//        {
//            case  .eyeBlinkLeft:
//               // print("You Blinked")
//                leftEye = .shut
//            case  .eyeBlinkRight:
//               // print("You Blinked")
//                rightEye = .shut
//            case .eyeLookOutLeft:
//                leftEye = .lookingLeft
//                rightEye = .lookingLeft
//            case .eyeLookInLeft:
//                leftEye = .lookingRight
//                rightEye = .lookingRight
//            case .eyeLookUpLeft:
//                leftEye = .lookingUp
//                rightEye = .lookingUp
//            case .eyeLookDownLeft:
//                leftEye = .lookingDown
//                rightEye = .lookingDown
//            case .eyeWideLeft:
//                leftEye = .lookingWide
//                rightEye = .lookingWide
//            case .browOuterUpLeft:
//                browLine = .up
//               faceView.topFace.image = UIImage(named:  "eyeLookDownLeft_browOuterUpLeft.png")
//            default: return
//        }
//        }
//
//        switch (leftEye, rightEye, browLine)
//        {
//            case (.lookingLeft, .lookingLeft, .up ):
//            faceView.topFace.image = UIImage(named:  "eyeLookOutLeft_browOuterUpLeft.png")
//        case (_, _, .up ):
//            faceView.topFace.image = UIImage(named:  "eyeLookOutLeft_browOuterUpLeft.png")
//            default: return
//        }
//    }
}

