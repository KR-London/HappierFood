
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

class customFaceARViewController: UIViewController {

    var sliderFeedback: ((_ value: Float) -> Void)?
    var shouldUpdateEmoji: Bool = true

    @IBOutlet weak var smileView: smileView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var faceView: handDrawnFaceView!
    @IBAction func sliderSliding(_ sender: Any) {
        if let feedback = sliderFeedback{
            feedback(slider!.value)
        }
        updateUI(value: -1 + 2*slider!.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(value: 0)
        warningLabel.alpha = 0
    }
    
    func sliderFeedback(handler: @escaping (_ value: Float) -> Void) {
        sliderFeedback = handler
    }
    
    func updateUI(value: Float){
        /// do i need a bit of safety code here - if I get a crazy input? Or is this handled as standard.
        smileView.mouthCurvature = Double(value)
    }
}

