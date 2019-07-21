
//
//  Created by Kate Roberts on 05/06/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class Detail3ViewController: UIViewController {
    
      var detailToDisplay = (photoFilename: "tick.jpg", foodName: "not initialised", rating: 0.0, triedOn: Date(), notes: "" )

    @IBOutlet weak var topFaceView: UIImageView!
    @IBOutlet weak var faceView: smileView!
    @IBOutlet weak var faceRating: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    faceView.mouthCurvature = detailToDisplay.rating
    }
}
