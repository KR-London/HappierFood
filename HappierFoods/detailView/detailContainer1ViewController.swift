//
//  detailContainer1ViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 14/05/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class detailContainer1ViewController: UIViewController {
    
    var PresentState = Costume.Unknown

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch PresentState
            {
        case .ReviewTriedViewController:
            titleLabel.text = "Review Progress"
        case .ReviewTargetViewController:
            titleLabel.text = "Review Target"
        default:
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "photoInputScreen")
            self.present(newViewController, animated: true, completion: nil)
        }
    }
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
